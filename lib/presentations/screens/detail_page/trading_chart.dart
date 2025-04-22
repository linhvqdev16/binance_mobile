import 'package:binance_mobile/presentations/provider/detail_page_provider/websocket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:candlesticks/candlesticks.dart';

class TradingChart extends ConsumerWidget {
  const TradingChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final candlesticks = ref.watch(candlesticksProvider);
    final marketData = ref.watch(marketDataProvider);

    // Convert our CandlestickData to the format expected by the candlesticks package
    final candles = candlesticks.map((candle) => Candle(
      date: candle.time,
      open: candle.open,
      high: candle.high,
      low: candle.low,
      close: candle.close,
      volume: candle.volume,
    )).toList();

    if (candles.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Expanded(
          child: Candlesticks(
            candles: candles,
            // onLoadMoreCandles: () {
            //   // In a real app, you would load more historical data here
            //   print('Load more candles requested');
            // },
            actions: [
              ToolBarAction(
                width: 50,
                onPressed: () {},
                child: const Icon(Icons.access_time),
              ),
              ToolBarAction(
                width: 50,
                onPressed: () {},
                child: const Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ],
    );
  }
}