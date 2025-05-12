import 'package:binance_mobile/data/models/models/coin_item_filter_model.dart';

abstract class CoinRepository{
  Future<List<CoinItemModel>> getTopListCoins();
}