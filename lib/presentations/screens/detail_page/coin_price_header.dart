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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with symbol and actions
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      symbol,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.star, color: Colors.amber),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.grid_view),
                onPressed: () {},
              ),
            ],
          ),

          // Price and percentage change
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Text(
                  "$priceText",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isPositive ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "${isPositive ? '+' : ''}$changeText%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isPositive ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Connection status indicator (for demo)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              isConnected ? "WebSocket Connected" : "Connecting...",
              style: TextStyle(
                fontSize: 12,
                color: isConnected ? Colors.green : Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
