import 'package:binance_mobile/presentations/provider/detail_page_provider/websocket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k_chart_plus/k_chart_plus.dart';

class TradingChart extends ConsumerWidget {

  TradingChart({super.key});

  late List<KLineEntity>? data;
  late ChartStyle chartStyle = ChartStyle();
  late ChartColors chartColors = ChartColors();
  bool volHidden = false;
  MainState mainState = MainState.MA;
  final List<SecondaryState> _secondaryStateLi = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final candlesticks = ref.watch(candlesticksProvider);
    final marketData = ref.watch(marketDataProvider);
    data = candlesticks
        .map((item) => KLineEntity.fromCustom(close: item.close,
                                              high: item.high,
                        low: item.low, open: item.open,
        time: item.time.toUtc().millisecondsSinceEpoch,
        vol: item.volume,
        amount: item.volume))
        .toList()
        .toList()
        .cast<KLineEntity>();
    DataUtil.calculate(data!);
    // final candles = candlesticks
    //     .map((candle) => Candle(
    //           epoch: candle.time.toUtc().millisecondsSinceEpoch,
    //           open: candle.open,
    //           high: candle.high,
    //           low: candle.low,
    //           close: candle.close,
    //         ))
    //     .toList();
    if (data == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return KChartWidget(
      data,
      chartStyle,
      chartColors,
      mBaseHeight: 500,
      isTrendLine: false,
      // mainState: mainState,
      // volHidden: volHidden,
      secondaryStateLi: _secondaryStateLi.toSet(),
      fixedLength: 1,
      timeFormat: TimeFormat.YEAR_MONTH_DAY_WITH_HOUR,
    );
  }
}
