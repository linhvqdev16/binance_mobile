
import 'dart:async';
import 'dart:convert';

import 'package:binance_mobile/core/env/load_env.dart';
import 'package:binance_mobile/core/error/exceptions.dart';
import 'package:binance_mobile/data/datasources/remote/binance/interface/crypto_remote_interface.dart';
import 'package:binance_mobile/data/models/models/crypto_ticker_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CryptoRemoteDataSourceImpl implements CryptoRemoteDataSource {
  @override
  Stream<List<CryptoTickerModel>> getCryptoTickerStream(List<String> symbols) {
    try {
      // Create a map to store the latest data for each symbol
      final tickerData = <String, CryptoTickerModel>{};

      // Initialize ticker data with default values
      for (final symbol in symbols) {
        tickerData[symbol] = CryptoTickerModel(
          symbol: symbol,
          price: '0',
          priceUsd: '0',
          percentChange: 0.0,
        );
      }

      // Create the streams string for the WebSocket connection
      final streams = symbols
          .map((symbol) => '${symbol.toLowerCase()}@ticker')
          .join('/');

      // Connect to Binance WebSocket
      final wsUrl = '${EnvLoad.BASE_WEB_SOCKET}/$streams';
      final channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      // Transform the WebSocket stream into a stream of CryptoTickerModel lists
      final controller = StreamController<List<CryptoTickerModel>>();

      final subscription = channel.stream.listen(
            (dynamic data) {
          final jsonData = jsonDecode(data);
          final symbol = jsonData['s'] as String;

          // Update the ticker data for this symbol
          if (symbols.contains(symbol)) {
            tickerData[symbol] = CryptoTickerModel.fromJson(jsonData);

            // Emit the current list of all tickers
            controller.add(tickerData.values.toList());
          }
        },
        onError: (error) {
          controller.addError(ServerException());
        },
        onDone: () {
          controller.close();
        },
      );
      controller.onCancel = () {
        subscription.cancel();
        channel.sink.close();
      };
      return controller.stream;
    } catch (e) {
      throw ConnectionException();
    }
  }
}
