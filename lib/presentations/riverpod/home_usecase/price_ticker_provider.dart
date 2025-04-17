import 'package:binance_mobile/core/error/error.dart';
import 'package:binance_mobile/data/models/response/price_ticker.dart';
import 'package:binance_mobile/data/repositories/interface/crypto_repository.dart';
import 'package:dartz/dartz.dart';

class GetCryptoStreamUseCase {
  final CryptoRepository repository;

  GetCryptoStreamUseCase({required this.repository});

  Stream<Either<ErrorHandle, List<CryptoTicker>>> execute(List<String> symbols) {
    return repository.getCryptoTickerStream(symbols);
  }
}