import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class MarketPageChart extends StatefulWidget {
  const MarketPageChart({super.key});

  @override
  State<MarketPageChart> createState() => _MarketPageChartState();
}

class _MarketPageChartState extends State<MarketPageChart> {
  //Biêur đồ barChart
  final int totalBars = 60;
  final Random random = Random();
  late List<double> barData;
  late List<bool> isIncrease;
  late List<double> purpleLine;
  late List<double> orangeLine;
  @override
  void initState() {
    super.initState();

    // Dữ liệu cột
    barData = List.generate(
      totalBars,
      (i) => 0.1 + random.nextDouble() * 1,
    );

    // Tăng giảm xen kẽ
    isIncrease = List.generate(totalBars, (i) => i % 2 == 0);

    // Đường tím: lấy trung bình cộng quanh cột
    purpleLine = [];
    for (int i = 0; i < totalBars; i++) {
      double avg = 0;
      int count = 0;
      for (int j = i - 2; j <= i + 2; j++) {
        if (j >= 0 && j < totalBars) {
          avg += barData[j];
          count++;
        }
      }
      purpleLine.add(avg / count);
    }

    // Đường cam: dao động nhẹ dựa trên đường tím
    orangeLine = List.generate(
      totalBars,
      (i) => purpleLine[i] + (random.nextDouble() - 0.5) * 0.2,
    );
  }

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double barWidth = screenWidth / totalBars;

    //Khai báo dữ liệu demo để hiện thị cho phần mua bán
    final buyOrders = [
      ['295,02', '18,11'],
      ['3.094,22', '18,10'],
      ['4.126,07', '18,09'],
      ['7.688,40', '18,08'],
    ];

    final sellOrders = [
      ['18,12', '3.004,53'],
      ['18,13', '8.378,03'],
      ['18,14', '10.425,12'],
      ['18,15', '5.686,63'],
    ];
    //mặc định chọn nút Sổ lệnh
    String selected = 'Sổ lệnh';
    String selectedValue = '0.1';
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            child: Column(
              children: [
                //Thông tin - dòng 1
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '18,10',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 125,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Giá cao nhất 24h',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '18,91',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 93,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'KL 24h(AVAX)',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '4,44M',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                //Thông tin - dòng 2
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '18,1 \$ ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: '+8,58%',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'Lớp 1 / Lớp 2',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 125,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Giá thấp nhất 24h',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '15,96',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 93,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'KL 24h(USDT)',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '4,44M',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                //Thời gian giao dịch
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Thời gian',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          '1h',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          '4h',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          '15p',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          '1 ngày',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Nhiều hơn',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          'Độ sâu',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            onPressed: () => {},
                            icon: const Icon(Icons.menu_open))
                      ],
                    ),
                  ),
                ),
                //Biểu đồ lên xuống
                SizedBox(
                  height: screenHeight / 3,
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: 10,
                      minY: 18.00,
                      maxY: 18.24,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: Colors.grey.withOpacity(0.2),
                          strokeWidth: 1,
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, _) {
                              return Text(
                                value.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              );
                            },
                            interval: 0.04,
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        // Đường chính màu vàng
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 18.10),
                            FlSpot(1, 18.22),
                            FlSpot(2, 18.04),
                            FlSpot(3, 18.18),
                            FlSpot(4, 18.02),
                            FlSpot(5, 18.14),
                            FlSpot(6, 18.03),
                            FlSpot(7, 18.20),
                            FlSpot(8, 18.08),
                            FlSpot(9, 18.19),
                            FlSpot(10, 18.11),
                          ],
                          isCurved: true,
                          color: Colors.orange,
                          barWidth: 2,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.orange.withOpacity(0.2),
                          ),
                          dotData: const FlDotData(show: false),
                        ),
                        // Đường MA60 màu xám
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 18.12),
                            FlSpot(1, 18.14),
                            FlSpot(2, 18.13),
                            FlSpot(3, 18.15),
                            FlSpot(4, 18.16),
                            FlSpot(5, 18.17),
                            FlSpot(6, 18.16),
                            FlSpot(7, 18.15),
                            FlSpot(8, 18.14),
                            FlSpot(9, 18.13),
                            FlSpot(10, 18.12),
                          ],
                          isCurved: true,
                          color: Colors.grey.shade600,
                          barWidth: 2,
                          dotData: const FlDotData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),

                //Vol and Ma
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Text(
                      'Vol: 413,14',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'MA (5): 602,14',
                      style: TextStyle(fontSize: 14, color: Colors.orange),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'MA (10): 824,98',
                      style: TextStyle(fontSize: 14, color: Colors.purple),
                    ),
                  ],
                ),
                //Biểu đồ: BarChart
                SizedBox(
                  // aspectRatio: 1,
                  height: 80,
                  child: Stack(
                    children: [
                      BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceEvenly,
                          maxY: 1.5,
                          barGroups: List.generate(totalBars, (i) {
                            return BarChartGroupData(
                              x: i,
                              barsSpace: 0,
                              barRods: [
                                BarChartRodData(
                                  toY: barData[i],
                                  width: barWidth,
                                  color:
                                      isIncrease[i] ? Colors.green : Colors.red,
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ],
                            );
                          }),
                          titlesData: const FlTitlesData(show: false),
                          gridData: const FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          barTouchData: BarTouchData(enabled: false),
                        ),
                      ),
                      LineChart(
                        LineChartData(
                          minY: 0,
                          maxY: 2,
                          lineBarsData: [
                            LineChartBarData(
                              spots: List.generate(
                                totalBars,
                                (i) => FlSpot(i.toDouble(), purpleLine[i]),
                              ),
                              isCurved: true,
                              color: Colors.purpleAccent,
                              barWidth: 2,
                              dotData: const FlDotData(show: false),
                            ),
                            LineChartBarData(
                              spots: List.generate(
                                totalBars,
                                (i) => FlSpot(i.toDouble(), orangeLine[i]),
                              ),
                              isCurved: true,
                              color: Colors.orangeAccent,
                              barWidth: 2,
                              dotData: const FlDotData(show: false),
                            ),
                          ],
                          titlesData: const FlTitlesData(show: false),
                          gridData: const FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                        ),
                      ),
                    ],
                  ),
                ),
                //Ngày - tháng - năm - giờ
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '2025-04-10 14:43',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '2025-04-10 14:43',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                //MA - EMA -BOLL
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey, width: 0.5),
                      bottom: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () => {},
                            child: const Text(
                              'MA',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                        TextButton(
                            onPressed: () => {},
                            child: const Text(
                              'EMA',
                              style: TextStyle(color: Colors.grey),
                            )),
                        TextButton(
                            onPressed: () => {},
                            child: const Text(
                              'BOLL',
                              style: TextStyle(color: Colors.grey),
                            )),
                        TextButton(
                            onPressed: () => {},
                            child: const Text(
                              'SAR',
                              style: TextStyle(color: Colors.grey),
                            )),
                        TextButton(
                            onPressed: () => {},
                            child: const Text(
                              'AVL',
                              style: TextStyle(color: Colors.grey),
                            )),
                        const Text('|',
                            style: TextStyle(fontSize: 25, color: Colors.grey)),
                        TextButton(
                            onPressed: () => {},
                            child: const Text(
                              'VOL',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                        TextButton(
                            onPressed: () => {},
                            child: const Text(
                              'MACD',
                              style: TextStyle(color: Colors.grey),
                            )),
                        TextButton(
                            onPressed: () => {},
                            child: const Text(
                              'RSI',
                              style: TextStyle(color: Colors.grey),
                            )),
                        TextButton(
                            onPressed: () => {},
                            child: const Text(
                              'KDJ',
                              style: TextStyle(color: Colors.grey),
                            )),
                      ],
                    ),
                  ),
                ),
                //Hôm nay, 7 ngày, 30 ngày
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hôm nay',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey)),
                        Text('4,26%',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.green))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('7 ngày',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey)),
                        Text('-8,31%',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.red))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('30 ngày',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey)),
                        Text('3,96%',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.green))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('90 ngày',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey)),
                        Text('-51,25%',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.red))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('180 ngày',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey)),
                        Text('-31.40%',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.red))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('1 năm',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey)),
                        Text('-61,55%',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.red))
                      ],
                    )
                  ],
                ),
                const Divider(color: Colors.grey, thickness: 0.5),
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: const Row(
                    children: [
                      Text(
                        'Sổ lệnh',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Giao dịch',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.orange),
                      )
                    ],
                  ),
                ),
                // Tỉ lệ %
                Row(
                  children: [
                    const Text(
                      '44,69%',
                      style: TextStyle(color: Colors.green),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 4469,
                      child: Container(
                        height: 6,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 5531,
                      child: Container(
                        height: 6,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      '55,31%',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                // Headers
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mua vào'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Bán ra'),
                              DropdownButton<String>(
                                value: selectedValue,
                                items:
                                    ['0.1', '0.2', '0.3'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      selectedValue = newValue;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...buyOrders.map((order) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  order[0],
                                  style: const TextStyle(color: Colors.black),
                                ),
                                Text(
                                  order[1],
                                  style: const TextStyle(color: Colors.green),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...sellOrders.map((sell) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  sell[0],
                                  style: const TextStyle(color: Colors.red),
                                ),
                                Text(
                                  sell[1],
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
                //footer
              ],
            ),
          ),
        ),
      ),
    );
  }
}
