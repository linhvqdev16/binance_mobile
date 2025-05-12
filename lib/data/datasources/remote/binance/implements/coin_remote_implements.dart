import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:binance_mobile/core/env/load_env.dart';
import 'package:binance_mobile/data/datasources/remote/binance/interface/coin_remote_interface.dart';
import 'package:binance_mobile/data/models/models/coin_item_filter_model.dart';

class CoinRemoteImplement extends CoinRemoteInterface{

  final String BASE_REST_URL = EnvLoad.BASE_URL;
  final client = http.Client();

  final List<String> topSymbols = [
    'BTCUSDT', 'ETHUSDT', 'BNBUSDT', 'XRPUSDT', 'ADAUSDT',
    'SOLUSDT', 'AVAXUSDT', 'DOGEUSDT', 'DOTUSDT', 'MATICUSDT',
    'LINKUSDT', 'TRXUSDT', 'ATOMUSDT', 'LTCUSDT', 'OPUSDT',
  ];
  @override
  Future<List<CoinItemModel>> getListTopCoins() async {
    final futures = topSymbols.map((symbol) async {
      final response = await client.get(
        Uri.parse('${BASE_REST_URL}/ticker/24hr?symbol=$symbol'),
        headers: {'User-Agent': 'Mozilla/5.0'},
      );
      if (response.statusCode == 200) {
        return CoinItemModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load coin $symbol');
      }
    });
    return await Future.wait(futures);
  }

}