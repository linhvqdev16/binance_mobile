import 'package:binance_mobile/data/models/models/market_data_model.dart';
import 'package:binance_mobile/presentations/provider/detail_page_provider/websocket_provider.dart';
import 'package:binance_mobile/presentations/screens/detail_page/coin_price_header.dart';
import 'package:binance_mobile/presentations/screens/detail_page/indicator_tabs.dart';
import 'package:binance_mobile/presentations/screens/detail_page/order_book.dart';
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

class _CoinDetailScreenState extends ConsumerState<CoinDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final numberFormat = NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Connect to WebSocket when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(websocketConnectionProvider.notifier).connect(widget.symbol);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    // Disconnect from WebSocket when the screen is disposed
    ref.read(websocketConnectionProvider.notifier).disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final marketData = ref.watch(marketDataProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Coin price header
            CoinPriceHeader(symbol: widget.symbol),

            // Tab bar
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.amber,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: 'Giá'),
                  Tab(text: 'Thông tin'),
                  Tab(text: 'Dữ liệu Giao dịch'),
                  Tab(text: 'Square'),
                ],
              ),
            ),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Price tab content
                  buildPriceTab(marketData),

                  // Info tab - placeholder
                  const Center(child: Text('Thông tin về coin')),

                  // Trading data tab - placeholder
                  const Center(child: Text('Dữ liệu giao dịch')),

                  // Square tab - placeholder
                  const Center(child: Text('Square')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPriceTab(MarketDataModel marketData) {
    return Column(
      children: [
        // Indicator tabs (MA, EMA, BOLL, etc.)
        const IndicatorTabs(),

        // Time period buttons
        const TimePeriodButtons(),

        // Trading chart
        Expanded(
          flex: 3,
          child: TradingChart(),
        ),

        // Extra info from second screenshot
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Giá cao nhất 24h', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(numberFormat.format(marketData.high24h), style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('KL 24h(BTC)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(marketData.volume24h.toStringAsFixed(2), style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Giá thấp nhất 24h', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(numberFormat.format(marketData.low24h), style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('KL 24h(USDT)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text('1.32B', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        // Order book
        Expanded(
          flex: 2,
          child: OrderBook(),
        ),

        // Trading buttons (Buy/Sell)
        const TradingButtons(),
      ],
    );
  }
}