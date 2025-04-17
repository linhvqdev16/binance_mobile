import 'package:binance_mobile/data/models/response/price_ticker.dart';
import 'package:binance_mobile/presentations/screens/home_page/crypto_item_widget.dart';
import 'package:flutter/material.dart';

class CryptoListWidget extends StatelessWidget {
  final List<CryptoTicker> tickers;
  final Size screenSize;

  const CryptoListWidget({Key? key, required this.tickers, required this.screenSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: tickers.length,
      itemBuilder: (context, index) {
        final ticker = tickers[index];
        return CryptoItemWidget(ticker: ticker, screenSize: screenSize);
      },
    );
  }
}
