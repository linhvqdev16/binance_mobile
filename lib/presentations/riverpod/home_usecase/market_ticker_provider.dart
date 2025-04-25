import 'package:binance_mobile/data/models/models/market_ticker_model.dart';
import 'package:binance_mobile/presentations/riverpod/home_usecase/market_ticker_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final marketProvider =
    StateNotifierProvider<MarketTickerNotifier, MarketTickerState>(
  (ref) => MarketTickerNotifier(
    watchlist: [
      'AVAXUSDT',
      'ONDOUSDT',
      'MKRUSDT',
      'ICPUSDT',
      'INJUSDT',
      'PENDLEUSDT',
      'OMUSDT',
      'RSRUSDT',
      'SNXUSDT',
      'POLYXUSDT',
      'USUALUSDT',
      'CHRUSDT',
      'TRUUSDT',
      'LUMIAUSDT',
      'DUSKUSDT',
      'HIFIUSDT',
      'LTOUSDT'
    ],
  ),
);

final favoriteProvider =
    StateNotifierProvider<MarketTickerNotifier, MarketTickerState>(
  (ref) => MarketTickerNotifier(
    watchlist: [
      'BNBUSDT',
      'BTCUSDT',
      'ETHUSDT',
      'SOLUSDT',
      'XRPUSDT',
      'REDUSDT',
      'ADAUSDT',
      'PEPEUSDT'
    ],
  ),
);

final alphaProvider =
    StateNotifierProvider<MarketTickerNotifier, MarketTickerState>(
  (ref) => MarketTickerNotifier(
    watchlist: [
      'BITCOINUSDT',
    ],
  ),
);
