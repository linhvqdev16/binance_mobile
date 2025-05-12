import 'package:binance_mobile/core/dependency_injection/injection_container.dart';
import 'package:binance_mobile/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k_chart_plus/k_chart_plus.dart';

// ignore: must_be_immutable
class TradingChart extends ConsumerWidget {
  TradingChart({super.key});
  late List<KLineEntity>? data;
  late ChartStyle chartStyle = ChartStyle();
  late ChartColors chartColors = ChartColors(upColor: ColorStyle.greenColor, dColor: Colors.white);
  bool volHidden = false;
  MainState mainState = MainState.MA;
  final List<SecondaryState> _secondaryStateLi = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final candlesticks = ref.watch(candlesticksProvider);
    data = candlesticks
        .map((item) => KLineEntity.fromCustom(
            close: item.close,
            high: item.high,
            low: item.low,
            open: item.open,
            time: item.time.toUtc().millisecondsSinceEpoch,
            vol: item.volume,
            amount: 0))
        .toList()
        .toList()
        .cast<KLineEntity>();

    if (data == null || data!.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    DataUtil.calculate(data!);
    // return KChartWidget(
    //     data,
    //     chartStyle,
    //     ChartColors(
    //       upColor: ColorStyle.greenColor,
    //       dnColor: ColorStyle.redColor,
    //       bgColor: Colors.white,
    //     ),
    //     mBaseHeight: 500,
    //     isTrendLine: false,
    //     // mainState: mainState,
    //     volHidden: false,
    //     secondaryStateLi: _secondaryStateLi.toSet(),
    //     fixedLength: 10,
    //     timeFormat: TimeFormat.YEAR_MONTH_DAY,
    //     verticalTextAlignment: VerticalTextAlignment.right);

    return KChartWidget(
      data,
      chartStyle,
      ChartColors(
        upColor: ColorStyle.greenColor,
        dnColor: ColorStyle.redColor,
        bgColor: Colors.white,
        ma5Color: Colors.orange,
        ma10Color: Colors.purple,
        ma30Color: Colors.grey,
      ),

      isLine: true,
      mainState: MainState.MA,
      volHidden: false,
      isTrendLine: false,
      // secondaryStateLi: const <SecondaryState>{},
      secondaryStateLi: _secondaryStateLi.toSet(),
      fixedLength: 20,
      timeFormat: TimeFormat.YEAR_MONTH_DAY_WITH_HOUR,
      verticalTextAlignment: VerticalTextAlignment.right,
      showNowPrice: true,
      isTapShowInfoDialog: true,
      showInfoDialog: true,
      materialInfoDialog: true,
    );
  }
}
