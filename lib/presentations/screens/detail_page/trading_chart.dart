//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:k_chart_plus/k_chart_plus.dart';
// import 'package:web_socket_channel/io.dart';
//
// class BinanceCandleChart extends StatefulWidget {
//   const BinanceCandleChart({super.key});
//
//   @override
//   State<BinanceCandleChart> createState() => _BinanceCandleChartState();
// }
//
// class _BinanceCandleChartState extends State<BinanceCandleChart> {
//   final String symbol = "btcusdt";
//   final String interval = "1m";
//   final List<KLineEntity> _datas = [];
//   late IOWebSocketChannel _channel;
//   bool _loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchInitialData();
//   }
//
//   Future<void> fetchInitialData() async {
//     final url = Uri.parse('https://api.binance.com/api/v3/klines?symbol=${symbol.toUpperCase()}&interval=$interval&limit=100');
//     final res = await http.get(url);
//     final List<dynamic> data = jsonDecode(res.body);
//
//     _datas.clear();
//     for (var e in data) {
//       _datas.add(KLineEntity.fromCustom(
//         open: double.parse(e[1]),
//         high: double.parse(e[2]),
//         low: double.parse(e[3]),
//         close: double.parse(e[4]),
//         vol: double.parse(e[5]),
//         time: e[0],
//       ));
//     }
//
//     _datas.sort((a, b) => a.time!.compareTo(b.time!));
//     DataUtil.calculate(_datas);
//     setState(() {
//       _loading = false;
//     });
//
//     // connectWebSocket();
//   }
//
//   void connectWebSocket() {
//     final socketUrl = 'wss://stream.binance.com:9443/ws/${symbol}@kline_$interval';
//     _channel = IOWebSocketChannel.connect(socketUrl);
//
//     _channel.stream.listen((event) {
//       final jsonData = json.decode(event);
//       final k = jsonData['k'];
//
//       if (k['x'] == false) {
//         final entity = KLineEntity.fromCustom(
//           open: double.parse(k['o']),
//           high: double.parse(k['h']),
//           low: double.parse(k['l']),
//           close: double.parse(k['c']),
//           vol: double.parse(k['v']),
//           time: k['t'],
//         );
//
//         _datas.removeWhere((e) => e.time == entity.time);
//         _datas.add(entity);
//         _datas.sort((a, b) => a.time!.compareTo(b.time!));
//         DataUtil.calculate(_datas);
//         setState(() {});
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _channel.sink.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _loading
//         ? const Center(child: CircularProgressIndicator())
//         : KChartWidget(
//       _datas,
//       ChartStyle(),
//       ChartColors(),
//       isLine: false,
//       mainState: MainState.MA,
//       volHidden: false,
//       isTrendLine: false,
//     );
//   }
// }


import 'package:binance_mobile/core/dependency_injection/injection_container.dart';
import 'package:binance_mobile/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k_chart_plus/k_chart_plus.dart';

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
        .map((item) => KLineEntity.fromCustom(close: item.close,
                                              high: item.high,
                        low: item.low, open: item.open,
        time: item.time.toUtc().millisecondsSinceEpoch,
        vol: item.volume,
        amount: 0))
        .toList()
        .toList()
        .cast<KLineEntity>();
    DataUtil.calculate(data!);
    if (data == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return KChartWidget(
      data,
      chartStyle,
        ChartColors(
          upColor: ColorStyle.greenColor,
          dnColor: ColorStyle.redColor,
          bgColor: Colors.white,
        ),
      mBaseHeight: 500,
      isTrendLine: false,
      // mainState: mainState,
      volHidden: false,
      secondaryStateLi: _secondaryStateLi.toSet(),
      fixedLength: 10,
      timeFormat: TimeFormat.YEAR_MONTH_DAY,
        verticalTextAlignment: VerticalTextAlignment.right
    );
  }
}
