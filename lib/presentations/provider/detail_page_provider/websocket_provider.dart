import 'dart:convert';

import 'package:binance_mobile/data/models/models/candlestick_data_model.dart';
import 'package:binance_mobile/data/models/models/market_data_model.dart';
import 'package:binance_mobile/data/models/models/market_percent_model.dart';
import 'package:binance_mobile/data/models/models/order_book_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../service/detail_page/websocket_service.dart';
import 'package:http/http.dart' as http;

class WebSocketState {
  final MarketDataModel marketData;
  final List<CandlestickData> candlesticks;
  final OrderBookData orderBook;
  final bool isConnected;
  final MarketPercentModel marketPercentModel;

  WebSocketState({
    required this.marketData,
    required this.candlesticks,
    required this.orderBook,
    this.isConnected = false,
    required this.marketPercentModel,
  });

  WebSocketState copyWith({
    MarketDataModel? marketData,
    List<CandlestickData>? candlesticks,
    OrderBookData? orderBook,
    bool? isConnected,
    MarketPercentModel? marketPercentModel,
  }) {
    return WebSocketState(
      marketData: marketData ?? this.marketData,
      candlesticks: candlesticks ?? this.candlesticks,
      orderBook: orderBook ?? this.orderBook,
      isConnected: isConnected ?? this.isConnected,marketPercentModel:  marketPercentModel ?? this.marketPercentModel

    );
  }
}

class WebSocketNotifier extends StateNotifier<WebSocketState> {
  WebSocketService? _webSocket;
  String? _currentSymbol;
  WebSocketNotifier() : super(WebSocketState(
    marketData: MarketDataModel(
      price: 0.0,
      priceChange: 0.0,
      priceChangePercent: 0.0,
      high24h: 0.0,
      low24h: 0.0,
      volume24h: 0.0,
      lastUpdated: DateTime.now(),
    ),
    marketPercentModel: MarketPercentModel(
      y1: 0.0,
      h24: 0.0,
      d180: 0.0,
      d90: 0.0,
      d30: 0.0,
      d7: 0.0
    ),
    candlesticks: [],
    orderBook: OrderBookData(
      bids: [],
      asks: [],
      lastUpdateId: 0,
    ),
  ));

  void connect(String symbol) async {
    await fetchInitialData(symbol);
    await calculatePercentChanges(symbol);
    if (_webSocket != null && _currentSymbol == symbol && _webSocket!.isConnected) return;
    disconnect();
    _currentSymbol = symbol;
    _webSocket = WebSocketService(
      baseUrl: 'wss://stream.binance.com:9443/ws',
      onMessage: (data){
        _handleWebSocketMessage(data as Map<String, dynamic>);
      },
      onConnected: () {
        state = state.copyWith(isConnected: true);
        _subscribeToStreams(symbol);
      },
      onError: (error) {
        state = state.copyWith(isConnected: false);
      },
      onDisconnected: () {
        state = state.copyWith(isConnected: false);
      },
    );
    _webSocket!.connect();
  }

  void disconnect() {
    _webSocket?.disconnect();
    _webSocket = null;
    _currentSymbol = null;
    state = state.copyWith(isConnected: false);
  }

  void _subscribeToStreams(String symbol) {
    final String symbolLower = symbol.replaceAll('/', '').toLowerCase();
    _webSocket?.subscribe([
      "$symbolLower@trade",
      "$symbolLower@depth300@100ms",
      "$symbolLower@kline_1m",
    ]);
  }
  void reconnect() {
    if (_currentSymbol != null) {
      Future.delayed(const Duration(seconds: 3), () {
        connect(_currentSymbol!);
      });
    }
  }
  void _handleWebSocketMessage(Map<String, dynamic> data) {
    if (data.containsKey('e')) {
      final eventType = data['e'];
      switch (eventType) {
        case 'trade':
          _handleTradeEvent(data);
          break;
        case 'depthUpdate':
          _handleDepthUpdate(data);
          break;
        case 'kline':
          _handleKlineUpdate(data);
          break;
      }
    }
  }
  Future<void> calculatePercentChanges(String symbol) async {
    final String symbolLower = symbol.replaceAll('/', '').toUpperCase();
    final response = await http.get( Uri.parse('https://api.binance.com/api/v3/klines?symbol=$symbolLower&interval=1d&limit=365'));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch historical data');
    }
    final List<dynamic> klines = jsonDecode(response.body);
    final Map<String, double> percentChanges = {
      '24h': 0.0,
      '7d': 0.0,
      '30d': 0.0,
      '90d': 0.0,
      '180d': 0.0,
      '1y': 0.0
    };
    final currentPrice = double.parse(klines.last[4]);
    if (klines.length > 1) {
      final price24h = double.parse(klines[klines.length - 2][4]);
      percentChanges['24h'] = ((currentPrice - price24h) / price24h) * 100;
    }
    if (klines.length > 7) {
      final price7d = double.parse(klines[klines.length - 8][4]);
      percentChanges['7d'] = ((currentPrice - price7d) / price7d) * 100;
    }
    if (klines.length > 30) {
      final price30d = double.parse(klines[klines.length - 31][4]);
      percentChanges['30d'] = ((currentPrice - price30d) / price30d) * 100;
    }
    if (klines.length > 90) {
      final price90d = double.parse(klines[klines.length - 91][4]);
      percentChanges['90d'] = ((currentPrice - price90d) / price90d) * 100;
    }
    if (klines.length > 180) {
      final price180d = double.parse(klines[klines.length - 181][4]);
      percentChanges['180d'] = ((currentPrice - price180d) / price180d) * 100;
    }
    if (klines.length >= 365) {
      final price1y = double.parse(klines[0][4]);
      percentChanges['1y'] = ((currentPrice - price1y) / price1y) * 100;
    }
    final MarketPercentModel model = MarketPercentModel(
        y1: percentChanges['1y'] ?? 0,
        h24: percentChanges['24h'] ?? 0,
        d180: percentChanges['180d'] ?? 0,
        d90: percentChanges['90d'] ?? 0,
        d30: percentChanges['30d'] ?? 0,
        d7: percentChanges['7d'] ?? 0);
    state = state.copyWith(marketPercentModel: model);
  }
  Future<void> fetchInitialData(String symbol) async {
      final String symbolLower = symbol.replaceAll('/', '').toUpperCase();
      final url = Uri.parse(
          'https://api.binance.com/api/v3/klines?symbol=${symbolLower}&interval=1m&limit=100');
      final res = await http.get(url);
      final List<dynamic> data = jsonDecode(res.body);
      List<CandlestickData>? datas = [];
      for (var e in data) {
        datas.add(CandlestickData(
          open: double.parse(e[1]),
          high: double.parse(e[2]),
          low: double.parse(e[3]),
          close: double.parse(e[4]),
          time: DateTime.fromMillisecondsSinceEpoch(e[0]),
          volume: double.parse(e[5]),
        ));
      }
      state = state.copyWith(candlesticks: datas);
  }

  void _handleTradeEvent(Map<String, dynamic> data) {
    final price = double.parse(data['p']);
    final updatedMarketData = state.marketData.copyWith(
      price: price,
      lastUpdated: DateTime.now(),
    );
    state = state.copyWith(marketData: updatedMarketData);
  }
  void _handleDepthUpdate(Map<String, dynamic> data) {
    final bids = data['b']?.map<OrderBookEntry>((bid) =>
        OrderBookEntry(
            price: double.parse(bid[0]),
            quantity: double.parse(bid[1])
        )
    )?.toList() ?? [];
    final asks = data['a']?.map<OrderBookEntry>((ask) =>
        OrderBookEntry(
            price: double.parse(ask[0]),
            quantity: double.parse(ask[1])
        )
    )?.toList() ?? [];
    final updatedOrderBook = state.orderBook.copyWith(
      bids: bids,
      asks: asks,
      lastUpdateId: data['lastUpdateId'] ?? state.orderBook.lastUpdateId,
    );
    state = state.copyWith(orderBook: updatedOrderBook);
  }
  void _handleKlineUpdate(Map<String, dynamic> data) {
    final k = data['k'];
    final newCandle = CandlestickData(
      time: DateTime.fromMillisecondsSinceEpoch(k['t']),
      open: double.parse(k['o']),
      high: double.parse(k['h']),
      low: double.parse(k['l']),
      close: double.parse(k['c']),
      volume: double.parse(k['v']),
    );
    final updatedCandlesticks = List<CandlestickData>.from(state.candlesticks);
    final existingIndex = updatedCandlesticks.indexWhere((candle) => candle.time.millisecondsSinceEpoch == newCandle.time.millisecondsSinceEpoch);
    if (existingIndex >= 0) {
      updatedCandlesticks[existingIndex] = newCandle;
    } else {
      updatedCandlesticks.add(newCandle);
      updatedCandlesticks.sort((a, b) => a.time.compareTo(b.time));
      if (updatedCandlesticks.length > 200) {
        updatedCandlesticks.removeAt(0);
      }
    }
    state = state.copyWith(candlesticks: updatedCandlesticks);
  }
}
