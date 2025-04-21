import 'package:binance_mobile/core/error/error.dart';
import 'package:binance_mobile/data/models/response/market_ticket.dart';
import 'package:dartz/dartz.dart';

abstract class MarketRepository {
  Stream<Either<ErrorHandle, List<MarketTicker>>> getMarketTickers(
      List<String> symbols);
  void closeConnection();
}
