import 'dart:async';
import 'package:binance_mobile/data/models/response/get_market_tickers.dart';
import 'package:binance_mobile/data/models/response/market_ticket.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarketTickerState {
  final bool isLoading;
  final List<MarketTicker> tickers;
  final String? errorMessage;

  // Constructor
  MarketTickerState({
    required this.isLoading,
    required this.tickers,
    this.errorMessage,
  });

  // Initial state
  factory MarketTickerState.initial() => MarketTickerState(
        isLoading: true,
        tickers: const [],
      );

  // Copy with method for immutability
  MarketTickerState copyWith({
    bool? isLoading,
    List<MarketTicker>? tickers,
    String? errorMessage,
  }) {
    return MarketTickerState(
      isLoading: isLoading ?? this.isLoading,
      tickers: tickers ?? this.tickers,
      errorMessage: errorMessage,
    );
  }
}

// Notifier class
class MarketTickerNotifier extends StateNotifier<MarketTickerState> {
  final GetMarketTickersUseCase getMarketTickersUseCase;
  StreamSubscription? _subscription;

  MarketTickerNotifier({required this.getMarketTickersUseCase})
      : super(MarketTickerState.initial()) {
    // Start fetching market data when created
    getMarketTickers();
  }

  Future<void> getMarketTickers() async {
    state = state.copyWith(isLoading: true);
    final symbols = [
      'BTCUSDT',
      'ETHUSDT',
      'BNBUSDT',
      'SOLUSDT',
      'AVAXUSDT',
      'ADAUSDT',
      'DOGEUSDT',
      'XRPUSDT',
      'DOTUSDT',
      'LINKUSDT'
    ];

    final stream = getMarketTickersUseCase.execute(symbols);

    _subscription = stream.listen(
      (result) {
        result.fold(
          (failure) {
            state = state.copyWith(
              isLoading: false,
              errorMessage: null,
            );
          },
          (tickers) {
            state = state.copyWith(
              isLoading: false,
              tickers: tickers,
              errorMessage: null,
            );
            print('Received tickers: $tickers');
          },
        );
      },
      onError: (error) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        );
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
