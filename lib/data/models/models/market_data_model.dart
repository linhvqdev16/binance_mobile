class MarketDataModel {
  final double price;
  final double priceChange;
  final double priceChangePercent;
  final double high24h;
  final double low24h;
  final double volume24h;
  final DateTime lastUpdated;
  final double openPrice;

  MarketDataModel({
    required this.price,
    required this.priceChange,
    required this.priceChangePercent,
    required this.high24h,
    required this.low24h,
    required this.volume24h,
    required this.lastUpdated,
    required this.openPrice
  });

  MarketDataModel copyWith({
    double? price,
    double? priceChange,
    double? priceChangePercent,
    double? high24h,
    double? low24h,
    double? volume24h,
    DateTime? lastUpdated,
    double? openPrice
  }) {
    return MarketDataModel(
      price: price ?? this.price,
      priceChange: priceChange ?? this.priceChange,
      priceChangePercent: priceChangePercent ?? this.priceChangePercent,
      high24h: high24h ?? this.high24h,
      low24h: low24h ?? this.low24h,
      volume24h: volume24h ?? this.volume24h,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      openPrice: openPrice ?? this.openPrice
    );
  }
}
