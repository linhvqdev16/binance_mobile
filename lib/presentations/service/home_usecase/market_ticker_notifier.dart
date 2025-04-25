import 'dart:convert';

import 'package:binance_mobile/core/utils/load_env.dart';
import 'package:binance_mobile/data/models/models/market_ticker_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MarketTickerNotifier extends StateNotifier<MarketTickerState> {
  final List<String> watchlist;
  WebSocketChannel? _channel;

  MarketTickerNotifier({required this.watchlist})
      : super(MarketTickerState(
          tickerData: {},
          prevPrices: {},
          percentChanges: {},
          volumes: {},
          isLoading: true,
        )) {
    _initWebSocket();
  }

  void _initWebSocket() {
    if (_channel != null) return;
    //lấy dữ liệu toàn bộ thị trường:!ticker@arr
    final wsURL =
        '${EnvLoad.BASE_WEB_SOCKET}/${watchlist.map((ticker) => '${ticker.toLowerCase()}@ticker').join('/')}';
    // print('WebSocket URL: $wsURL');
    _channel = WebSocketChannel.connect(Uri.parse(wsURL));

    _channel!.stream.listen((message) {
      final decodedMessage = jsonDecode(message);

      final newTickerData = Map<String, dynamic>.from(state.tickerData);
      final newPercentChanges = Map<String, double>.from(state.percentChanges);
      final newVolumes = Map<String, double>.from(state.volumes);
      final newPrevPrices = Map<String, double>.from(state.prevPrices);
      final symbol = decodedMessage['s'];
      if (watchlist.contains(symbol)) {
        final closePrice = double.parse(decodedMessage['c']);
        final openPrice = double.parse(decodedMessage['o']);
        final percentChange = ((closePrice - openPrice) / openPrice) * 100;
        final volume = double.parse(decodedMessage['q']) / 1000000;

        newTickerData[symbol] = closePrice;
        newPercentChanges[symbol] = percentChange;
        newVolumes[symbol] = volume;

        if (!newPrevPrices.containsKey(symbol)) {
          newPrevPrices[symbol] = closePrice;
        }
      }

      state = state.copyWith(
        tickerData: newTickerData,
        percentChanges: newPercentChanges,
        volumes: newVolumes,
        prevPrices: newPrevPrices,
        isLoading: false,
      );

      Future.delayed(const Duration(milliseconds: 300), () {
        final updatedPrevPrices = Map<String, double>.from(state.prevPrices);
        final symbol = decodedMessage['s'];
        if (watchlist.contains(symbol)) {
          updatedPrevPrices[symbol] = double.parse(decodedMessage['c']);
        }
        state = state.copyWith(prevPrices: updatedPrevPrices);
      });
    });
  }

  @override
  void dispose() {
    _channel?.sink.close();
    super.dispose();
  }
}
