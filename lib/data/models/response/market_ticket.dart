class MarketTicker {
  final String symbol;
  final String price;
  final double priceChange;
  final double percentChange;
  final double volume24h;
  final double high24h;
  final double low24h;

  MarketTicker({
    required this.symbol,
    required this.price,
    required this.priceChange,
    required this.percentChange,
    required this.volume24h,
    required this.high24h,
    required this.low24h,
  });

  factory MarketTicker.fromJson(Map<String, dynamic> json) {
    return MarketTicker(
      symbol: json['s'] as String,
      price: json['c'] as String,
      priceChange: double.parse(json['p']),
      percentChange: double.parse(json['P']),
      volume24h: double.parse(json['v']),
      high24h: double.parse(json['h']),
      low24h: double.parse(json['l']),
    );
  }
}
