// lib/data/repositories/market_repository_impl.dart
import 'dart:async';
import 'package:binance_mobile/core/error/error.dart';
import 'package:binance_mobile/core/error/exceptions.dart';
import 'package:binance_mobile/data/datasources/remote/binance/implements/market_remote_implements.dart';
import 'package:binance_mobile/data/datasources/remote/binance/interface/market_remote_interface.dart';
import 'package:binance_mobile/data/models/response/market_ticket.dart';
import 'package:dartz/dartz.dart';

class MarketRepositoryImpl implements MarketRepository {
  final MarketRemoteDataSource remoteDataSource;

  MarketRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Either<ErrorHandle, List<MarketTicker>>> getMarketTickers(
      List<String> symbols) async* {
    try {
      final stream = remoteDataSource.getMarketTickers(symbols);

      await for (final tickerList in stream) {
        yield Right(tickerList);
      }
    } on ServerException {
      yield Left(ServerFailure());
    } on ConnectionException {
      yield Left(ConnectionFailure());
    }
  }

  // return remoteDataSource
  //       .getMarketTickers(symbols)
  //       .map((tickers) => Right(tickers))
  //       .handleError((error) => Left(ServerFailure(message: error.toString())));

  @override
  void closeConnection() {
    remoteDataSource.dispose();
  }
}
