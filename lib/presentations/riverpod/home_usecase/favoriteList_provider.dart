import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class FavoriteList {
  final Map<String, dynamic> tickerData;
  final Map<String, double> prevPrices;
  final Map<String, double> percentChanges;
  final Map<String, double> volumes;
  final bool isLoading;

  FavoriteList({
    required this.tickerData,
    required this.prevPrices,
    required this.percentChanges,
    required this.volumes,
    required this.isLoading,
  });

  FavoriteList copyWith({
    Map<String, dynamic>? tickerData,
    Map<String, double>? prevPrices,
    Map<String, double>? percentChanges,
    Map<String, double>? volumes,
    bool? isLoading,
  }) {
    return FavoriteList(
      tickerData: tickerData ?? this.tickerData,
      prevPrices: prevPrices ?? this.prevPrices,
      percentChanges: percentChanges ?? this.percentChanges,
      volumes: volumes ?? this.volumes,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// Class để quản lý kết nối websocket và cập nhật dữ liệu
class FavoriteListNotifier extends StateNotifier<FavoriteList> {
  WebSocketChannel? _channel;
  final List<String> watchlist = [
    'BNBUSDT',
    'BTCUSDT',
    'ETHUSDT',
    'SOLUSDT',
    'XRPUSDT',
    'REDUSDT',
    'ADAUSDT',
    'PEPEUSDT'
  ];

  final Map<String, int> leverages = {
    'BNBUSDT': 10,
    'BTCUSDT': 10,
    'ETHUSDT': 10,
    'SOLUSDT': 5,
    'XRPUSDT': 10,
    'REDUSDT': 5,
    'ADAUSDT': 10,
    'PEPEUSDT': 5
  };

  FavoriteListNotifier()
      : super(FavoriteList(
          tickerData: {},
          prevPrices: {},
          percentChanges: {},
          volumes: {},
          isLoading: true,
        )) {
    _initWebSocket();
  }

  void _initWebSocket() {
    // Đã kết nối rồi thì không kết nối lại
    if (_channel != null) return;

    _channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/!ticker@arr'),
    );

    _channel!.stream.listen((message) {
      final decodedMessage = jsonDecode(message);

      Map<String, dynamic> newTickerData = Map.from(state.tickerData);
      Map<String, double> newPercentChanges = Map.from(state.percentChanges);
      Map<String, double> newVolumes = Map.from(state.volumes);
      Map<String, double> prevPrices = Map.from(state.prevPrices);

      for (var ticker in decodedMessage) {
        final symbol = ticker['s'];
        if (watchlist.contains(symbol)) {
          final double closePrice = double.parse(ticker['c']);
          final double openPrice = double.parse(ticker['o']);
          final percentChange = ((closePrice - openPrice) / openPrice) * 100;
          final double volume = double.parse(ticker['q']) / 1000000;

          newTickerData[symbol] = closePrice;
          newPercentChanges[symbol] = percentChange;
          newVolumes[symbol] = volume;

          if (!prevPrices.containsKey(symbol)) {
            prevPrices[symbol] = closePrice;
          }
        }
      }

      state = state.copyWith(
        tickerData: newTickerData,
        percentChanges: newPercentChanges,
        volumes: newVolumes,
        prevPrices: prevPrices,
        isLoading: false,
      );

      // Cập nhật giá trước đó sau 300ms
      Future.delayed(const Duration(milliseconds: 300), () {
        Map<String, double> newPrevPrices = Map.from(state.prevPrices);

        for (var ticker in decodedMessage) {
          final symbol = ticker['s'];
          if (watchlist.contains(symbol)) {
            newPrevPrices[symbol] = double.parse(ticker['c']);
          }
        }

        state = state.copyWith(
          prevPrices: newPrevPrices,
        );
      });
    });
  }

  @override
  void dispose() {
    _channel?.sink.close();
    super.dispose();
  }
}

// Provider để lưu trữ và quản lý dữ liệu yeu thích
final favoriteListProvider =
    StateNotifierProvider<FavoriteListNotifier, FavoriteList>((ref) {
  return FavoriteListNotifier();
});
