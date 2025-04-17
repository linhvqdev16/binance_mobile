import 'package:binance_mobile/core/error/error.dart';
import 'package:binance_mobile/core/error/exceptions.dart';
import 'package:binance_mobile/data/datasources/remote/binance/interface/crypto_remote_interface.dart';
import 'package:binance_mobile/data/models/response/price_ticker.dart';
import 'package:binance_mobile/data/repositories/interface/crypto_repository.dart';
import 'package:dartz/dartz.dart';


class CryptoRepositoryImpl implements CryptoRepository {
  final CryptoRemoteDataSource remoteDataSource;

  CryptoRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Either<ErrorHandle, List<CryptoTicker>>> getCryptoTickerStream(List<String> symbols) async* {
    try {
      final stream = remoteDataSource.getCryptoTickerStream(symbols);

      await for (final tickerList in stream) {
        yield Right(tickerList);
      }
    } on ServerException {
      yield Left(ServerFailure());
    } on ConnectionException {
      yield Left(ConnectionFailure());
    }
  }
}
