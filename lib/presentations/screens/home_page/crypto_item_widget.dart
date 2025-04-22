import 'package:binance_mobile/core/styles/colors.dart';
import 'package:binance_mobile/data/models/response/price_ticker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CryptoItemWidget extends StatelessWidget {
  final CryptoTicker ticker;
  final Size screenSize;

  const CryptoItemWidget(
      {Key? key, required this.ticker, required this.screenSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedSymbol = ticker.symbol.replaceAll('USDT', '');
    final priceFormatter = NumberFormat('#,##0.00', 'en_US');
    final priceDisplay = double.tryParse(ticker.price) != null
        ? double.parse(ticker.price) < 1
            ? ticker.price
            : priceFormatter.format(double.parse(ticker.price))
        : ticker.price;
    final Color changeColor = ticker.percentChange >= 0
        ? ColorStyle.greenColor()
        : ColorStyle.redColor();
    final String changeSign = ticker.percentChange >= 0 ? '+' : '';
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.04,
        vertical: screenSize.height * 0.015,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  ticker.symbol,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '/USDT',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  priceDisplay,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$priceDisplay \$',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: screenSize.width * 0.04),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.02,
                vertical: screenSize.height * 0.007,
              ),
              decoration: BoxDecoration(
                color: changeColor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: Text(
                '$changeSign${ticker.percentChange.toStringAsFixed(2)}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
