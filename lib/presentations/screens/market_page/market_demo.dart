// main.dart
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class BinanceTracker extends StatefulWidget {
  const BinanceTracker({Key? key}) : super(key: key);

  @override
  State<BinanceTracker> createState() => _BinanceTrackerState();
}

class _BinanceTrackerState extends State<BinanceTracker> {
  late WebSocketChannel _channel;
  String symbol = 'btcusdt';
  String interval = '1m';

  double currentPrice = 0.0;
  double priceChangePercent = 0.0;
  double highPrice = 0.0;
  double lowPrice = 0.0;
  double volume = 0.0;

  final List<double> priceData = [];
  final List<double> maData = [];
  final List<double> volumeData = [];
  final List<DateTime> timeData = [];

  final List<String> timeFrames = ['1h', '4h', '15m', '1 ngày', 'Nhiều hơn'];
  String selectedTimeFrame = '1h';

  final List<String> indicators = ['MA', 'EMA', 'BOLL', 'SAR', 'AVL', 'VOL'];
  String selectedIndicator = 'MA';

  @override
  void initState() {
    super.initState();
    connectWebSocket();
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
        currentPrice = double.parse(kline['c']);
        highPrice = double.parse(kline['h']);
        lowPrice = double.parse(kline['l']);
        volume = double.parse(kline['v']);

        // Calculate price change percentage (simulated for demo)
        priceChangePercent = 0.58;

        // Add data for chart
        if (priceData.length >= 30) {
          priceData.removeAt(0);
          maData.removeAt(0);
          volumeData.removeAt(0);
          timeData.removeAt(0);
        }

        priceData.add(currentPrice);
        // Simple moving average calculation (5-period)
        if (priceData.length >= 5) {
          double sum = 0;
          for (int i = priceData.length - 5; i < priceData.length; i++) {
            sum += priceData[i];
          }
          maData.add(sum / 5);
        } else {
          maData.add(currentPrice);
        }

        volumeData.add(volume / 1000); // Scale down for visualization
        timeData.add(DateTime.fromMillisecondsSinceEpoch(kline['t']));
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
    // Add initial dummy data if empty
    if (priceData.isEmpty) {
      final now = DateTime.now();
      for (int i = 0; i < 30; i++) {
        priceData.add(18000 + (i * 10));
        maData.add(18100 - (i * 5));
        volumeData.add(400 + (i * 20));
        timeData.add(now.subtract(Duration(minutes: 30 - i)));
      }
      currentPrice = priceData.last;
      highPrice = 18921;
      lowPrice = 15960;
      volume = 444000;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildPriceInfo(),
            _buildTimeFrameSelector(),
            Expanded(
              flex: 3,
              child: _buildPriceChart(),
            ),
            SizedBox(height: 8),
            _buildVolumeChart(),
            _buildIndicatorTabs(),
            _buildStatisticsRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text('5:15', style: TextStyle(color: Colors.grey)),
          Spacer(),
          Row(
            children: [
              Icon(Icons.network_cell, size: 16, color: Colors.grey),
              SizedBox(width: 8),
              Icon(Icons.wifi, size: 16, color: Colors.grey),
              SizedBox(width: 8),
              Icon(Icons.battery_full, size: 16, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                NumberFormat.decimalPattern().format(currentPrice),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Giá cao nhất 24h: ${NumberFormat.decimalPattern().format(highPrice)}',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    'Giá thấp nhất 24h: ${NumberFormat.decimalPattern().format(lowPrice)}',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Text(
                '${currentPrice.toStringAsFixed(1)}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  '+${priceChangePercent.toStringAsFixed(2)}%',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Lớp 1 / Lớp 2',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeFrameSelector() {
    return Container(
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: timeFrames.length,
        itemBuilder: (context, index) {
          final isSelected = timeFrames[index] == selectedTimeFrame;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTimeFrame = timeFrames[index];
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 16),
              padding: EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.center,
              decoration: isSelected
                  ? BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.blue, width: 2),
                      ),
                    )
                  : null,
              child: Text(
                timeFrames[index],
                style: TextStyle(
                  color: isSelected ? Colors.blue : Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPriceChart() {
    if (priceData.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 0.5,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 0.5,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 0.5,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: priceData.length.toDouble() - 1,
          minY: (priceData.reduce((a, b) => a < b ? a : b) * 0.995),
          maxY: (priceData.reduce((a, b) => a > b ? a : b) * 1.005),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.black,
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  return LineTooltipItem(
                    '${barSpot.y.toStringAsFixed(2)}',
                    TextStyle(color: barSpot.bar.color),
                  );
                }).toList();
              },
            ),
          ),
          lineBarsData: [
            // Price line
            LineChartBarData(
              spots: List.generate(priceData.length, (index) {
                return FlSpot(index.toDouble(), priceData[index]);
              }),
              isCurved: true,
              color: Colors.orange,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.orange.withOpacity(0.1),
              ),
            ),
            // MA line
            LineChartBarData(
              spots: List.generate(maData.length, (index) {
                return FlSpot(index.toDouble(), maData[index]);
              }),
              isCurved: true,
              color: Colors.blue,
              barWidth: 1.5,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVolumeChart() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          maxY: volumeData.reduce((a, b) => a > b ? a : b) * 1.2,
          minY: 0,
          groupsSpace: 4,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(
            volumeData.length,
            (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: volumeData[index],
                  color: index % 2 == 0 ? Colors.green : Colors.red,
                  width: 4,
                  borderRadius: BorderRadius.zero,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIndicatorTabs() {
    return Container(
      height: 40,
      padding: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: indicators.map((indicator) {
          final isSelected = indicator == selectedIndicator;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndicator = indicator;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: isSelected
                  ? BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.blue, width: 2),
                      ),
                    )
                  : null,
              child: Text(
                indicator,
                style: TextStyle(
                  color: isSelected ? Colors.blue : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatisticsRow() {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatItem('1 tháng nay', '+4.26%'),
          _buildStatItem('7 ngày', '-8.11%'),
          _buildStatItem('30 ngày', '+5.76%'),
          _buildStatItem('90 ngày', '-91.25%'),
          _buildStatItem('180 ngày', '+31.40%'),
          _buildStatItem('1 năm', '+61.05%'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    final isPositive = value.contains('+');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey, fontSize: 10),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: isPositive ? Colors.green : Colors.red,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.grey,
          size: 24,
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
