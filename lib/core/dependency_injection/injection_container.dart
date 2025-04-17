import 'package:binance_mobile/data/datasources/remote/binance/implements/crypto_remote_implements.dart';
import 'package:binance_mobile/data/datasources/remote/binance/interface/crypto_remote_interface.dart';
import 'package:binance_mobile/data/repositories/implements/crypto_repository_impl.dart';
import 'package:binance_mobile/data/repositories/interface/crypto_repository.dart';
import 'package:binance_mobile/presentations/riverpod/home_usecase/crypto_notifier.dart';
import 'package:binance_mobile/presentations/riverpod/home_usecase/price_ticker_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cryptoRemoteDataSourceProvider = Provider<CryptoRemoteDataSource>(
      (ref) => CryptoRemoteDataSourceImpl(),
);

// Provider for repository
final cryptoRepositoryProvider = Provider<CryptoRepository>(
      (ref) => CryptoRepositoryImpl(
    remoteDataSource: ref.watch(cryptoRemoteDataSourceProvider),
  ),
);

// Provider for use case
final getCryptoStreamUseCaseProvider = Provider<GetCryptoStreamUseCase>(
      (ref) => GetCryptoStreamUseCase(
    repository: ref.watch(cryptoRepositoryProvider),
  ),
);

final cryptoNotifierProvider = StateNotifierProvider<CryptoNotifier, CryptoState>(
      (ref) => CryptoNotifier(
    getCryptoStreamUseCase: ref.watch(getCryptoStreamUseCaseProvider),
  ),
);

Future<void> init() async {
  // Any initialization logic if needed
}
