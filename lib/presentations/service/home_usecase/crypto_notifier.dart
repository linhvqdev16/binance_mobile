import 'dart:async';
import 'package:binance_mobile/data/models/response/price_ticker.dart';
import 'package:binance_mobile/presentations/service/home_usecase/price_ticker_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CryptoState {
  final bool isLoading;
  final List<CryptoTicker> tickers;
  final String? errorMessage;

  CryptoState({
    required this.isLoading,
    required this.tickers,
    this.errorMessage,
  });

  // Initial state
  factory CryptoState.initial() => CryptoState(
        isLoading: true,
        tickers: const [],
      );

  // Copy with method for immutability
  CryptoState copyWith({
    bool? isLoading,
    List<CryptoTicker>? tickers,
    String? errorMessage,
  }) {
    return CryptoState(
      isLoading: isLoading ?? this.isLoading,
      tickers: tickers ?? this.tickers,
      errorMessage: errorMessage,
    );
  }
}

// Notifier class
class CryptoNotifier extends StateNotifier<CryptoState> {
  final GetCryptoStreamUseCase getCryptoStreamUseCase;
  StreamSubscription? _subscription;

  CryptoNotifier({required this.getCryptoStreamUseCase})
      : super(CryptoState.initial()) {
    // Start fetching cryptocurrency data when created
    fetchCryptoData();
  }

  Future<void> fetchCryptoData() async {
    state = state.copyWith(isLoading: true);
    final symbols = ['SOLUSDT', 'OMUSDT', 'BTCUSDT', 'BNBUSDT', 'ETHUSDT'];

    final stream = getCryptoStreamUseCase.execute(symbols);

    _subscription = stream.listen(
      (result) {
        result.fold(
          (failure) {
            state = state.copyWith(
              isLoading: false,
              errorMessage: 'Failed to fetch cryptocurrency data',
            );
          },
          (tickers) {
            state = state.copyWith(
              isLoading: false,
              tickers: tickers,
              errorMessage: null,
            );
          },
        );
      },
      onError: (error) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'An error occurred: $error',
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
