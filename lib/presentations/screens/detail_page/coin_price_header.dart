import 'package:binance_mobile/presentations/provider/detail_page_provider/websocket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CoinPriceHeader extends ConsumerWidget {
  final String symbol;
  final numberFormat = NumberFormat("#,##0.00", "en_US");

  CoinPriceHeader({super.key, required this.symbol});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marketData = ref.watch(marketDataProvider);
    final isConnected = ref.watch(connectionStatusProvider);

    final priceText = numberFormat.format(marketData.price);
    final changeText = marketData.priceChangePercent.toStringAsFixed(2);
    final isPositive = marketData.priceChangePercent >= 0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/left_arrow.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    symbol,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/down-arrow.png',
                      width: 10,
                      height: 10,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/star.png',
                      width: 15,
                      height: 15,
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/share.png',
                      width: 15,
                      height: 15,
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/grid.png',
                      width: 15,
                      height: 15,
                    ),
                  ),
                ],
              )
            ],
          ),

          // Padding(
          //   padding: const EdgeInsets.only(left: 12),
          //   child: Row(
          //     children: [
          //       Text(
          //         priceText,
          //         style: const TextStyle(
          //           fontSize: 24,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.green,
          //         ),
          //       ),
          //       const SizedBox(width: 8),
          //       Container(
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          //         decoration: BoxDecoration(
          //           color: isPositive
          //               ? Colors.green.withOpacity(0.2)
          //               : Colors.red.withOpacity(0.2),
          //           borderRadius: BorderRadius.circular(4),
          //         ),
          //         child: Text(
          //           "${isPositive ? '+' : ''}$changeText%",
          //           style: TextStyle(
          //             fontSize: 14,
          //             fontWeight: FontWeight.bold,
          //             color: isPositive ? Colors.green : Colors.red,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
