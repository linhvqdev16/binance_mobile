import 'package:equatable/equatable.dart';

class CryptoTicker extends Equatable {
  final String symbol;
  final String price;
  final String priceUsd;
  final double percentChange;

  const CryptoTicker({
    required this.symbol,
    required this.price,
    required this.priceUsd,
    required this.percentChange,
  });

  @override
  List<Object> get props => [symbol, price, priceUsd, percentChange];
}
