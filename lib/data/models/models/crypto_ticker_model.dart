import 'package:binance_mobile/data/models/response/price_ticker.dart';

class CryptoTickerModel extends CryptoTicker {
  const CryptoTickerModel({
    required super.symbol,
    required super.price,
    required super.priceUsd,
    required super.percentChange,
  });

  factory CryptoTickerModel.fromJson(Map<String, dynamic> json) {
    return CryptoTickerModel(
      symbol: json['s'],
      price: json['c'],
      priceUsd: json['c'], // For simplicity, we're using the same value
      percentChange: double.parse(json['P']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'price': price,
      'priceUsd': priceUsd,
      'percentChange': percentChange,
    };
  }
}
