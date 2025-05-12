import 'package:binance_mobile/data/datasources/remote/binance/implements/coin_remote_implements.dart';
import 'package:binance_mobile/data/models/models/coin_item_filter_model.dart';
import 'package:binance_mobile/data/repositories/implements/coin_repository_impl.dart';
import 'package:binance_mobile/domains/usecase/get_coin_list_usecases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coinProvider = StateNotifierProvider<CoinNotifier, AsyncValue<List<CoinItemModel>>>((ref) {
  final datasource = CoinRemoteImplement();
  final repository = CoinRepositoryImpl(datasource);
  final useCase = GetCoinsUseCase(repository);
  return CoinNotifier(useCase);
});

class CoinNotifier extends StateNotifier<AsyncValue<List<CoinItemModel>>> {
  final GetCoinsUseCase useCase;
  CoinNotifier(this.useCase) : super(const AsyncLoading()) {
    loadCoins();
  }
  Future<void> loadCoins() async {
    try {
      final result = await useCase();
      state = AsyncData(result);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
