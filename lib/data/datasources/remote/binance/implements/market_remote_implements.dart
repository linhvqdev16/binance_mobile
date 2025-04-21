import 'dart:async';
import 'dart:convert';
import 'package:binance_mobile/core/env/load_env.dart';
import 'package:binance_mobile/data/models/response/market_ticket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

abstract class MarketRemoteDataSource {
  Stream<List<MarketTicker>> getMarketTickers(List<String> symbols);
  void dispose();
}

class MarketRemoteDataSourceImpl implements MarketRemoteDataSource {
  WebSocketChannel? _channel;
  final StreamController<List<MarketTicker>> _tickersController =
      StreamController<List<MarketTicker>>.broadcast();
  final List<MarketTicker> _tickers = [];
  bool _isConnected = false;

  MarketRemoteDataSourceImpl();

  @override
  Stream<List<MarketTicker>> getMarketTickers(List<String> symbols) {
    if (!_isConnected) {
      _connectWebSocket(symbols);
    }
    return _tickersController.stream;
  }

  void _connectWebSocket(List<String> symbols) {
    final List<String> streams =
        symbols.map((symbol) => '${symbol.toLowerCase()}@ticker').toList();

    final String streamsParam = streams.join('/');
    final wsUrl = '${EnvLoad.BASE_WEB_SOCKET}/$streamsParam';
    // final Uri uri = Uri.parse('wss://stream.binance.com:9443/ws/$streamsParam');

    _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
    _isConnected = true;

    _channel!.stream.listen(
      (dynamic message) {
        final data = jsonDecode(message as String);
        final ticker = MarketTicker.fromJson(data);

        // Update ticker if it already exists, otherwise add it
        final index = _tickers.indexWhere((t) => t.symbol == ticker.symbol);
        if (index >= 0) {
          _tickers[index] = ticker;
        } else {
          _tickers.add(ticker);
        }

        _tickersController.add(List.from(_tickers));
      },
      onError: (error) {
        print('WebSocket error: $error');
        _reconnect(symbols);
      },
      onDone: () {
        print('WebSocket connection closed');
        _reconnect(symbols);
      },
    );
  }

  void _reconnect(List<String> symbols) {
    _isConnected = false;
    Future.delayed(const Duration(seconds: 5), () {
      if (!_isConnected) {
        _connectWebSocket(symbols);
      }
    });
  }

  @override
  void dispose() {
    _channel?.sink.close(status.goingAway);
    _tickersController.close();
    _isConnected = false;
  }
}
