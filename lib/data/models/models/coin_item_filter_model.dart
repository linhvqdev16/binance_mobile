import 'package:freezed_annotation/freezed_annotation.dart';

part 'coin_item_filter_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CoinItemModel {
  @JsonKey(name: 'symbol')
  late String symbol;
  @JsonKey(name: 'priceChange')
  late String priceChange;
  @JsonKey(name: 'priceChangePercent')
  late String priceChangePercent;
  @JsonKey(name: 'volume')
  late String volume;
  @JsonKey(name: 'quoteVolume')
  late String quoteVolume;
  @JsonKey(name: 'highPrice')
  late String highPrice;
  @JsonKey(name: 'openPrice')
  late String openPrice;
  @JsonKey(name: 'lowPrice')
  late String lowPrice;
  @JsonKey(name: 'lastQty')
  late String lastQty;
  @JsonKey(name: 'lastPrice')
  late String lastPrice;
  @JsonKey(name: 'askPrice')
  late String askPrice;

  CoinItemModel(
      {required this.symbol,
      required this.volume,
      required this.askPrice,
      required this.highPrice,
      required this.lastPrice,
      required this.lastQty,
      required this.lowPrice,
      required this.openPrice,
      required this.priceChange,
      required this.priceChangePercent,
      required this.quoteVolume});

  factory CoinItemModel.fromJson(Map<String, dynamic> json) => _$CoinItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoinItemModelToJson(this);
}
