// providers/websocket_provider.dart
import 'dart:convert';
import 'package:binance_mobile/data/models/models/candlestick_data_model.dart';
import 'package:binance_mobile/data/models/models/market_data_model.dart';
import 'package:binance_mobile/data/models/models/order_book_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../service/detail_page/websocket_service.dart';

// State class to hold market data
class WebSocketState {
  final MarketDataModel marketData;
  final List<CandlestickData> candlesticks;
  final OrderBookData orderBook;
  final bool isConnected;

  WebSocketState({
    required this.marketData,
    required this.candlesticks,
    required this.orderBook,
    this.isConnected = false,
  });

  WebSocketState copyWith({
    MarketDataModel? marketData,
    List<CandlestickData>? candlesticks,
    OrderBookData? orderBook,
    bool? isConnected,
  }) {
    return WebSocketState(
      marketData: marketData ?? this.marketData,
      candlesticks: candlesticks ?? this.candlesticks,
      orderBook: orderBook ?? this.orderBook,
      isConnected: isConnected ?? this.isConnected,
    );
  }
}

// Define the WebSocket notifier
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
    candlesticks: [],
    orderBook: OrderBookData(
      bids: [],
      asks: [],
      lastUpdateId: 0,
    ),
  ));

  void connect(String symbol) {
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
        print('WebSocket Error: $error');
        state = state.copyWith(isConnected: false);
      },
      onDisconnected: () {
        print('WebSocket disconnected');
        state = state.copyWith(isConnected: false);
      },
    );

    _webSocket!.connect();

    // Load initial mock data
    _loadMockData(symbol);
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
      "$symbolLower@depth20@100ms",
      "$symbolLower@kline_1m",
    ]);
  }

  // Reconnect to WebSocket
  void reconnect() {
    if (_currentSymbol != null) {
      Future.delayed(const Duration(seconds: 3), () {
        connect(_currentSymbol!);
      });
    }
  }

  // Handle WebSocket messages
  void _handleWebSocketMessage(Map<String, dynamic> data) {
    if (data.containsKey('e')) {
      final eventType = data['e'];

      // Handle different event types
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

  // Handle trade events
  void _handleTradeEvent(Map<String, dynamic> data) {
    final price = double.parse(data['p']);

    // Update market data with new price
    final updatedMarketData = state.marketData.copyWith(
      price: price,
      lastUpdated: DateTime.now(),
    );

    state = state.copyWith(marketData: updatedMarketData);
  }

  // Handle order book updates
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

  // Handle candlestick updates
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

    // Find and update existing candle or add new one
    final updatedCandlesticks = List<CandlestickData>.from(state.candlesticks);

    final existingIndex = updatedCandlesticks.indexWhere(
            (candle) => candle.time.millisecondsSinceEpoch == newCandle.time.millisecondsSinceEpoch
    );

    if (existingIndex >= 0) {
      updatedCandlesticks[existingIndex] = newCandle;
    } else {
      updatedCandlesticks.add(newCandle);

      // Sort by time
      updatedCandlesticks.sort((a, b) => a.time.compareTo(b.time));

      // Limit the number of candles to keep
      if (updatedCandlesticks.length > 200) {
        updatedCandlesticks.removeAt(0);
      }
    }

    state = state.copyWith(candlesticks: updatedCandlesticks);
  }

  // Load mock data for demonstration
  void _loadMockData(String symbol) {
    // Mock market data
    final marketData = MarketDataModel(
      price: 87439.63,
      priceChange: 2213.81,
      priceChangePercent: 2.58,
      high24h: 87640.00,
      low24h: 83949.52,
      volume24h: 66.56510,
      lastUpdated: DateTime.now(),
    );

    // Mock order book
    final List<OrderBookEntry> bids = [
      OrderBookEntry(price: 87423.46, quantity: 7.04051),
      OrderBookEntry(price: 87423.45, quantity: 0.00037),
      OrderBookEntry(price: 87423.38, quantity: 0.02927),
      OrderBookEntry(price: 87423.23, quantity: 0.08959),
      OrderBookEntry(price: 87423.22, quantity: 0.01000),
      OrderBookEntry(price: 87423.21, quantity: 0.03007),
      OrderBookEntry(price: 87423.20, quantity: 0.04580),
      OrderBookEntry(price: 87422.00, quantity: 0.08590),
      OrderBookEntry(price: 87421.48, quantity: 0.00040),
      OrderBookEntry(price: 87421.47, quantity: 0.00040),
    ];

    final List<OrderBookEntry> asks = [
      OrderBookEntry(price: 87423.47, quantity: 1.11229),
      OrderBookEntry(price: 87423.48, quantity: 0.00034),
      OrderBookEntry(price: 87423.49, quantity: 0.00021),
      OrderBookEntry(price: 87423.50, quantity: 0.02014),
      OrderBookEntry(price: 87423.51, quantity: 0.00007),
      OrderBookEntry(price: 87423.59, quantity: 0.00021),
      OrderBookEntry(price: 87423.60, quantity: 0.02014),
      OrderBookEntry(price: 87423.63, quantity: 0.00013),
      OrderBookEntry(price: 87429.28, quantity: 0.00006),
      OrderBookEntry(price: 87430.45, quantity: 0.00228),
    ];

    final orderBook = OrderBookData(
      bids: bids,
      asks: asks,
      lastUpdateId: 123456789,
    );

    // Mock candlestick data
    final now = DateTime.now();
    final List<CandlestickData> candlesticks = [];

    for (int i = 0; i < 100; i++) {
      final time = now.subtract(Duration(minutes: 100 - i));
      double open = 85000 + (i * 30) + (i % 2 == 0 ? -50 : 50);
      double close = open + (i % 3 == 0 ? 100 : -50);

      candlesticks.add(CandlestickData(
        time: time,
        open: open,
        high: close > open ? close + 20 : open + 20,
        low: close < open ? close - 20 : open - 20,
        close: close,
        volume: 10 + (i % 10),
      ));
    }

    state = state.copyWith(
      marketData: marketData,
      orderBook: orderBook,
      candlesticks: candlesticks,
      isConnected: true,
    );
  }
}

// Provider for the WebSocket connection
final websocketConnectionProvider = StateNotifierProvider<WebSocketNotifier, WebSocketState>((ref) {
  return WebSocketNotifier();
});

// Individual providers for specific parts of the state
final marketDataProvider = Provider<MarketDataModel>((ref) {
  return ref.watch(websocketConnectionProvider).marketData;
});

final candlesticksProvider = Provider<List<CandlestickData>>((ref) {
  return ref.watch(websocketConnectionProvider).candlesticks;
});

final orderBookProvider = Provider<OrderBookData>((ref) {
  return ref.watch(websocketConnectionProvider).orderBook;
});

final connectionStatusProvider = Provider<bool>((ref) {
  return ref.watch(websocketConnectionProvider).isConnected;
});