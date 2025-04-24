import 'package:binance_mobile/core/dependency_injection/injection_container.dart';
import 'package:binance_mobile/core/styles/colors.dart';
import 'package:binance_mobile/data/models/models/market_data_model.dart';
import 'package:binance_mobile/presentations/provider/detail_page_provider/websocket_provider.dart';
import 'package:binance_mobile/presentations/screens/detail_page/coin_price_header.dart';
import 'package:binance_mobile/presentations/screens/detail_page/indicator_tabs.dart';
import 'package:binance_mobile/presentations/screens/detail_page/order_book.dart';
import 'package:binance_mobile/presentations/screens/detail_page/time_view_selected.dart';
import 'package:binance_mobile/presentations/screens/detail_page/trading_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'time_period_buttons.dart';
import 'trading_chart.dart';

class CoinDetailScreen extends ConsumerStatefulWidget {
  final String symbol;

  const CoinDetailScreen({super.key, required this.symbol});

  @override
  ConsumerState<CoinDetailScreen> createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends ConsumerState<CoinDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final numberFormat = NumberFormat("#,##0.0", "en_US");

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(websocketConnectionProvider.notifier).connect(widget.symbol);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    ref.read(websocketConnectionProvider.notifier).disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CoinPriceHeader(symbol: widget.symbol),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(decoration: BoxDecoration(border: Border( bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 0.1))),
                width: MediaQuery.of(context).size.width,
                child: TabBar(
                  controller: _tabController,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  labelColor: Colors.black,
                  isScrollable: true, // add this property
                  unselectedLabelColor: const Color(0xff585861).withOpacity(0.4),
                  indicatorColor: Colors.amber,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w500),
                  tabs: const [
                    Tab(text: 'Giá'),
                    Tab(text: 'Thông tin'),
                    Tab(text: 'Dữ liệu Giao dịch'),
                    Tab(text: 'Square'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  buildPriceTab(),
                  const Text('Thông tin về coin'),
                  const Text('Dữ liệu giao dịch'),
                  const Text('Square'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPriceTab() {
    final marketData = ref.watch(marketDataProvider);
    final priceText = numberFormat.format(marketData.price);
    final changeText = marketData.priceChangePercent.toStringAsFixed(2);
    final isPositive = marketData.priceChangePercent >= 0;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Giá gần nhất',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          'assets/icons/down-arrow.png',
                          width: 8,
                          height: 8,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    priceText,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ColorStyle.greenColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       Text(
                        '$priceText \$',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "${isPositive ? '+' : ''}$changeText%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isPositive ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Giá đánh dấu $priceText',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Text(
                               'Giá cao nhất 24h',
                               style: TextStyle(
                                   fontSize: 12,
                                   fontWeight: FontWeight.normal,
                                   color: Colors.grey),
                             ),
                              Text(
                               priceText,
                               style: const TextStyle(
                                   fontSize: 12,
                                   fontWeight: FontWeight.normal,
                                   color: Colors.black),
                             ),
                             const Text(
                               'Giá thấp nhất 24h',
                               style: TextStyle(
                                   fontSize: 12,
                                   fontWeight: FontWeight.normal,
                                   color: Colors.grey),
                             ),
                             Text(
                               priceText,
                               style: const TextStyle(
                                   fontSize: 12,
                                   fontWeight: FontWeight.normal,
                                   color: Colors.black),
                             ),
                           ],
                         ),
                         const SizedBox(width: 10,),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Text(
                               'KL 24h(BTC)',
                               style: TextStyle(
                                   fontSize: 12,
                                   fontWeight: FontWeight.normal,
                                   color: Colors.grey),
                             ),
                             Text(
                               priceText,
                               style: const TextStyle(
                                   fontSize: 12,
                                   fontWeight: FontWeight.normal,
                                   color: Colors.black),
                             ),
                             const Text(
                               'KL 24h(USDT)',
                               style: TextStyle(
                                   fontSize: 12,
                                   fontWeight: FontWeight.normal,
                                   color: Colors.grey),
                             ),
                             Text(
                               priceText,
                               style: const TextStyle(
                                   fontSize: 12,
                                   fontWeight: FontWeight.normal,
                                   color: Colors.black),
                             ),
                           ],
                         )
                       ],
                     )
                  ],
                )
              ],
            ),
          ),
          const TimeViewSelected(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: TradingChart(),
          ),
          const IndicatorTabs(),
          const TimePeriodButtons(),
          OrderBook(symbol: widget.symbol)
        ],
      ),
    );
  }
}
