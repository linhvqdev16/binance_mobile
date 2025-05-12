import 'package:binance_mobile/data/models/models/coin_item_filter_model.dart';
import 'package:binance_mobile/data/repositories/interface/coin_repository.dart';

class GetCoinsUseCase {

  final CoinRepository repository;
  GetCoinsUseCase(this.repository);

  Future<List<CoinItemModel>> call() async => await repository.getTopListCoins();

}