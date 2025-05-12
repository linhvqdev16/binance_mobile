// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_item_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinItemModel _$CoinItemModelFromJson(Map<String, dynamic> json) =>
    CoinItemModel(
      symbol: json['symbol'] as String,
      volume: json['volume'] as String,
      askPrice: json['askPrice'] as String,
      highPrice: json['highPrice'] as String,
      lastPrice: json['lastPrice'] as String,
      lastQty: json['lastQty'] as String,
      lowPrice: json['lowPrice'] as String,
      openPrice: json['openPrice'] as String,
      priceChange: json['priceChange'] as String,
      priceChangePercent: json['priceChangePercent'] as String,
      quoteVolume: json['quoteVolume'] as String,
    );

Map<String, dynamic> _$CoinItemModelToJson(CoinItemModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'priceChange': instance.priceChange,
      'priceChangePercent': instance.priceChangePercent,
      'volume': instance.volume,
      'quoteVolume': instance.quoteVolume,
      'highPrice': instance.highPrice,
      'openPrice': instance.openPrice,
      'lowPrice': instance.lowPrice,
      'lastQty': instance.lastQty,
      'lastPrice': instance.lastPrice,
      'askPrice': instance.askPrice,
    };
