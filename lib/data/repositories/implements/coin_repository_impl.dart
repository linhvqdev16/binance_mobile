import 'package:binance_mobile/data/datasources/remote/binance/implements/coin_remote_implements.dart';
import 'package:binance_mobile/data/models/models/coin_item_filter_model.dart';
import 'package:binance_mobile/data/repositories/interface/coin_repository.dart';

class CoinRepositoryImpl extends CoinRepository{

  final CoinRemoteImplement coinRemoteImplement;

  CoinRepositoryImpl(this.coinRemoteImplement);

  @override
  Future<List<CoinItemModel>> getTopListCoins() {
    return coinRemoteImplement.getListTopCoins();
  }

}