class MarketPercentModel {
  final double h24;
  final double d7;
  final double d30;
  final double d90;
  final double d180;
  final double y1;


  MarketPercentModel({
    required this.h24,
    required this.d7,
    required this.d30,
    required this.d90,
    required this.d180,
    required this.y1,
  });

  MarketPercentModel copyWith({
    double? h24,
    double? d7,
    double? d30,
    double? d90,
    double? d180,
    double? y1
  }) {
    return MarketPercentModel(
      d7: d7 ?? this.d7,
      d30: d30 ?? this.d30,
      d90: d90 ?? this.d90,
      d180: d180 ?? this.d180,
      h24: h24 ?? this.h24,
      y1: y1 ?? this.y1
    );
  }
}
