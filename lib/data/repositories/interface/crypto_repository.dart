import 'package:binance_mobile/core/error/error.dart';
import 'package:binance_mobile/data/models/response/price_ticker.dart';
import 'package:dartz/dartz.dart';

abstract class CryptoRepository {
  Stream<Either<ErrorHandle, List<CryptoTicker>>> getCryptoTickerStream(List<String> symbols);
}