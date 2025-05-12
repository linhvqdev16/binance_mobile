import 'package:binance_mobile/core/styles/colors.dart';
import 'package:binance_mobile/presentations/provider/coin_list_item/coin_list_item_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinListItemPopup extends ConsumerWidget {
  const CoinListItemPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coinState = ref.watch(coinProvider);
    return ListView.builder(
      itemCount: coinState.value?.length,
      itemBuilder: (context, index) {
        final coin = coinState.value?[index];
        return ListTile(
          leading: const Icon(Icons.star_border),
          title: Text(coin?.symbol ?? ""),
          subtitle: Text(coin?.volume ?? ""),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                (coin?.priceChange ?? '').toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${double.parse(coin?.priceChange ?? '0') > 0 ? '+' : ''}${double.parse(coin?.priceChange ?? '0').toStringAsFixed(2)}%',
                style: TextStyle(color: double.parse(coin?.priceChange ?? '0') >= 0 ? ColorStyle.greenColor : ColorStyle.redColor),
              ),
            ],
          ),
        );
      },
    );
  }
}