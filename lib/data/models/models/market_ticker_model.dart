class MarketTickerState {
  final Map<String, dynamic> tickerData;
  final Map<String, double> prevPrices;
  final Map<String, double> percentChanges;
  final Map<String, double> volumes;
  final bool isLoading;

  MarketTickerState({
    required this.tickerData,
    required this.prevPrices,
    required this.percentChanges,
    required this.volumes,
    required this.isLoading,
  });

  MarketTickerState copyWith({
    Map<String, dynamic>? tickerData,
    Map<String, double>? prevPrices,
    Map<String, double>? percentChanges,
    Map<String, double>? volumes,
    bool? isLoading,
  }) {
    return MarketTickerState(
      tickerData: tickerData ?? this.tickerData,
      prevPrices: prevPrices ?? this.prevPrices,
      percentChanges: percentChanges ?? this.percentChanges,
      volumes: volumes ?? this.volumes,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
