import 'dart:convert';

import 'package:binance_mobile/data/models/models/candlestick_data_model.dart';
import 'package:binance_mobile/data/models/models/market_percent_model.dart';
import 'package:binance_mobile/data/models/models/order_book_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../service/detail_page/websocket_service.dart';
import 'package:http/http.dart' as http;

class BidsAskSocketState {
  final OrderBookData orderBook;

  BidsAskSocketState({
    required this.orderBook,
  });

  BidsAskSocketState copyWith({
    OrderBookData? orderBook,
  }) {
    return BidsAskSocketState(
        orderBook: orderBook ?? this.orderBook,

    );
  }
}

class BidsAskSocketNotifier extends StateNotifier<BidsAskSocketState> {
  WebSocketService? _webSocket;
  String? _currentSymbol;
  BidsAskSocketNotifier() : super(BidsAskSocketState(
    orderBook: OrderBookData(
      bids: [],
      asks: [],
      lastUpdateId: 0,
    ),
  ));

  void connect(String symbol) async {
    if (_webSocket != null && _currentSymbol == symbol && _webSocket!.isConnected) return;
    disconnect();
    _currentSymbol = symbol;
    _webSocket = WebSocketService(
      baseUrl: 'wss://stream.binance.com:9443/stream?streams=btcusdt@depth20@100ms',
      onMessage: (data){
        _handleWebSocketMessage(data as Map<String, dynamic>);
      },
      onConnected: () {
      },
      onError: (error) {
      },
      onDisconnected: () {
      },
    );
    _webSocket!.connect();
  }
  void disconnect() {
    _webSocket?.disconnect();
    _webSocket = null;
    _currentSymbol = null;
  }
  void reconnect() {
    if (_currentSymbol != null) {
      Future.delayed(const Duration(seconds: 3), () {
        connect(_currentSymbol!);
      });
    }
  }
  void _handleWebSocketMessage(Map<String, dynamic> data) {
    _handleDepthUpdate(data['data'] as Map<String, dynamic>);
  }

  void _handleDepthUpdate(Map<String, dynamic> data) {
    final bids = data['bids']?.map<OrderBookEntry>((bid) =>
        OrderBookEntry(
            price: double.parse(bid[0]),
            quantity: double.parse(bid[1])
        )
    )?.toList() ?? [];
    final asks = data['asks']?.map<OrderBookEntry>((ask) =>
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
}
