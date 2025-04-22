import 'package:binance_mobile/presentations/provider/detail_page_provider/websocket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class OrderBook extends ConsumerStatefulWidget {
  const OrderBook({super.key});

  @override
  ConsumerState<OrderBook> createState() => _OrderBookState();
}

class _OrderBookState extends ConsumerState<OrderBook> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final numberFormat = NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderBook = ref.watch(orderBookProvider);
    final totalBidQuantity = orderBook.bids.fold<double>(
        0, (sum, entry) => sum + entry.quantity);
    final totalAskQuantity = orderBook.asks.fold<double>(
        0, (sum, entry) => sum + entry.quantity);
    final totalQuantity = totalBidQuantity + totalAskQuantity;

    final buyPercentage = totalQuantity > 0
        ? (totalBidQuantity / totalQuantity * 100)
        : 0.0;
    final sellPercentage = 100 - buyPercentage;

    return Column(
        children: [
        // Order book header with tabs
        Container(
        decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5),
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
        ),
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.amber,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'Số lệnh'),
              Tab(text: 'Giao dịch'),
            ],
          ),
        ),

          // Buy/Sell percentage indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  flex: buyPercentage.round(),
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Expanded(
                  flex: sellPercentage.round(),
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Percentage labels
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '${buyPercentage.toStringAsFixed(2)}%',
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Text(
                  '${sellPercentage.toStringAsFixed(2)}%',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Column headers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: const [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Mua vào',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      'Giá',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Bán ra',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),

          // Order book entries
          Expanded(
            child: ListView.builder(
              itemCount: orderBook.bids.length,
              itemBuilder: (context, index) {
                final bid = orderBook.bids[index];
                final ask = index < orderBook.asks.length ? orderBook.asks[index] : null;

                // Find max quantity for proportional width
                final maxQuantity = [bid.quantity, ask?.quantity ?? 0].reduce((a, b) => a > b ? a : b);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      // Buy quantity
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 20,
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.2),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(2),
                                    bottomLeft: Radius.circular(2),
                                  ),
                                ),
                                width: bid.quantity / maxQuantity * 100,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Text(
                                    bid.quantity.toStringAsFixed(5),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Price - buy side
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 20,
                          alignment: Alignment.center,
                          child: Text(
                            numberFormat.format(bid.price),
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),

                      // Price - sell side
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 20,
                          alignment: Alignment.center,
                          child: ask != null
                              ? Text(
                            numberFormat.format(ask.price),
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          )
                              : const SizedBox(),
                        ),
                      ),

                      // Sell quantity
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            if (ask != null)
                              Expanded(
                                child: Container(
                                  height: 20,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    ask.quantity.toStringAsFixed(5),
                                    style: const TextStyle(fontSize: 12),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
    );
  }
}