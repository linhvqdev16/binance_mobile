import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

class BinanceChart extends StatefulWidget {
  const BinanceChart({Key? key}) : super(key: key);

  @override
  State<BinanceChart> createState() => _BinanceChartState();
}

class _BinanceChartState extends State<BinanceChart> {
  late WebSocketChannel _channel;
  String symbol = 'btcusdt';
  String interval = '1m';

  List<double> priceData = [];
  List<double> maData = [];
  List<double> ma10Data = [];
  double volume = 0;

  @override
  void initState() {
    super.initState();
    // Initialize with sample data
    _initializeChartData();
    // Connect to Binance WebSocket
    connectWebSocket();
  }

  void _initializeChartData() {
    // Sample data to match the chart pattern in the image
    priceData = [
      18.15,
      18.20,
      18.18,
      18.10,
      18.05,
      18.00,
      18.02,
      18.07,
      18.15,
      18.20,
      18.18,
      18.10,
      18.05,
      18.02,
      18.10,
      18.16,
      18.14,
      18.05,
      18.02,
      18.00,
      18.02,
      18.07,
      18.12,
      18.18,
      18.20,
      18.17,
      18.12,
      18.07,
      18.12
    ];

    // Calculate simple moving average (5-period) to match blue line
    maData = [];
    for (int i = 0; i < priceData.length; i++) {
      if (i < 4) {
        maData.add(priceData[i]);
      } else {
        double sum = 0;
        for (int j = i - 4; j <= i; j++) {
          sum += priceData[j];
        }
        maData.add(sum / 5);
      }
    }

    // Calculate 10-period MA for display at bottom
    ma10Data = [];
    for (int i = 0; i < priceData.length; i++) {
      if (i < 9) {
        ma10Data.add(priceData[i]);
      } else {
        double sum = 0;
        for (int j = i - 9; j <= i; j++) {
          sum += priceData[j];
        }
        ma10Data.add(sum / 10);
      }
    }

    // Set volume
    volume = 413.14;
  }

  void connectWebSocket() {
    _channel = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/$symbol@kline_$interval',
    );

    _channel.stream.listen((message) {
      final data = jsonDecode(message);
      updateData(data);
    }, onError: (error) {
      print('WebSocket Error: $error');
      reconnect();
    }, onDone: () {
      print('WebSocket closed');
      reconnect();
    });
  }

  void reconnect() {
    Future.delayed(const Duration(seconds: 2), () {
      connectWebSocket();
    });
  }

  void updateData(dynamic data) {
    if (data['e'] == 'kline') {
      final kline = data['k'];

      setState(() {
        // Update latest price
        final newPrice = double.parse(kline['c']);

        if (priceData.length >= 30) {
          priceData.removeAt(0);
        }
        priceData.add(newPrice);

        // Update MA
        if (priceData.length >= 5) {
          double sum = 0;
          for (int i = priceData.length - 5; i < priceData.length; i++) {
            sum += priceData[i];
          }

          if (maData.length >= 30) {
            maData.removeAt(0);
          }
          maData.add(sum / 5);
        }

        // Update MA(10)
        if (priceData.length >= 10) {
          double sum = 0;
          for (int i = priceData.length - 10; i < priceData.length; i++) {
            sum += priceData[i];
          }

          if (ma10Data.length >= 30) {
            ma10Data.removeAt(0);
          }
          ma10Data.add(sum / 10);
        }

        // Update volume
        volume = double.parse(kline['v']);
      });
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Find min and max values for Y-axis
    final maxY = priceData.reduce((a, b) => a > b ? a : b) + 0.02;
    final minY = priceData.reduce((a, b) => a < b ? a : b) - 0.02;

    return Container(
      height: 240,
      padding:
          const EdgeInsets.only(right: 16.0, left: 4.0, top: 8.0, bottom: 8.0),
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        children: [
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 0.04,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 0.5,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toStringAsFixed(2),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.left,
                        );
                      },
                      interval: 0.04,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: priceData.length.toDouble() - 1,
                minY: minY,
                maxY: maxY,
                lineTouchData: LineTouchData(enabled: false),
                clipData: FlClipData.all(),
                lineBarsData: [
                  // Price line (orange)
                  LineChartBarData(
                    spots: List.generate(priceData.length, (index) {
                      return FlSpot(index.toDouble(), priceData[index]);
                    }),
                    isCurved: true,
                    curveSmoothness: 0.3,
                    color: Colors.orange,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.orange.withOpacity(0.15),
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange.withOpacity(0.25),
                          Colors.orange.withOpacity(0.05),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // MA line (blue)
                  LineChartBarData(
                    spots: List.generate(maData.length, (index) {
                      return FlSpot(index.toDouble(), maData[index]);
                    }),
                    isCurved: true,
                    curveSmoothness: 0.3,
                    color: Colors.blue,
                    barWidth: 1.5,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Text(
                  'Vol: ${volume.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'MA (5): ${maData.last.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 11,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'MA (10): ${ma10Data.isNotEmpty ? ma10Data.last.toStringAsFixed(2) : "--"}',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
