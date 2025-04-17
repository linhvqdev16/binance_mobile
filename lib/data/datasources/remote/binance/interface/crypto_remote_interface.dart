import 'package:binance_mobile/data/models/models/crypto_ticker_model.dart';

abstract class CryptoRemoteDataSource {
  Stream<List<CryptoTickerModel>> getCryptoTickerStream(List<String> symbols);
}