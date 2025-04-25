import 'package:binance_mobile/data/datasources/remote/binance/implements/crypto_remote_implements.dart';
import 'package:binance_mobile/data/datasources/remote/binance/interface/crypto_remote_interface.dart';
import 'package:binance_mobile/data/models/models/candlestick_data_model.dart';
import 'package:binance_mobile/data/models/models/market_data_model.dart';
import 'package:binance_mobile/data/models/models/market_percent_model.dart';
import 'package:binance_mobile/data/models/models/order_book_data.dart';
import 'package:binance_mobile/data/repositories/implements/crypto_repository_impl.dart';
import 'package:binance_mobile/data/repositories/interface/crypto_repository.dart';
import 'package:binance_mobile/presentations/provider/detail_page_provider/bids_ask_socket_service.dart';
import 'package:binance_mobile/presentations/provider/detail_page_provider/websocket_provider.dart';
import 'package:binance_mobile/presentations/service/home_usecase/crypto_notifier.dart';
import 'package:binance_mobile/presentations/service/home_usecase/price_ticker_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cryptoRemoteDataSourceProvider = Provider<CryptoRemoteDataSource>(
      (ref) => CryptoRemoteDataSourceImpl(),
);

final cryptoRepositoryProvider = Provider<CryptoRepository>(
      (ref) => CryptoRepositoryImpl(
    remoteDataSource: ref.watch(cryptoRemoteDataSourceProvider),
  ),
);
final getCryptoStreamUseCaseProvider = Provider<GetCryptoStreamUseCase>(
      (ref) => GetCryptoStreamUseCase(
    repository: ref.watch(cryptoRepositoryProvider),
  ),
);

final cryptoNotifierProvider = StateNotifierProvider<CryptoNotifier, CryptoState>(
      (ref) => CryptoNotifier(
    getCryptoStreamUseCase: ref.watch(getCryptoStreamUseCaseProvider),
  ),
);

final websocketConnectionProvider = StateNotifierProvider<WebSocketNotifier, WebSocketState>((ref) {
  return WebSocketNotifier();
});

final websocketBidsAskProvider = StateNotifierProvider<BidsAskSocketNotifier, BidsAskSocketState>((ref) {
  return BidsAskSocketNotifier();
});
final marketDataProvider = Provider<MarketDataModel>((ref) {
  return ref.watch(websocketConnectionProvider).marketData;
});
final marketPercentProvider = Provider<MarketPercentModel>((ref) {
  return ref.watch(websocketConnectionProvider).marketPercentModel;
});
final candlesticksProvider = Provider<List<CandlestickData>>((ref) {
  return ref.watch(websocketConnectionProvider).candlesticks;
});
final orderBookProvider = Provider<OrderBookData>((ref) {
  return ref.watch(websocketBidsAskProvider).orderBook;
});
final connectionStatusProvider = Provider<bool>((ref) {
  return ref.watch(websocketConnectionProvider).isConnected;
});
final selectedIndexProvider = StateProvider<int>((ref) => 0);
Future<void> init() async {
  // Any initialization logic if needed
}
