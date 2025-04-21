// lib/domain/usecases/get_market_tickers.dart
import 'package:binance_mobile/core/error/error.dart';
import 'package:binance_mobile/data/datasources/remote/binance/interface/market_remote_interface.dart';
import 'package:binance_mobile/data/models/response/market_ticket.dart';
import 'package:dartz/dartz.dart';

class GetMarketTickersUseCase {
  final MarketRepository repository;

  GetMarketTickersUseCase(this.repository);

  Stream<Either<ErrorHandle, List<MarketTicker>>> execute(
      List<String> symbols) {
    return repository.getMarketTickers(symbols);
  }

  void dispose() {
    repository.closeConnection();
  }
}
