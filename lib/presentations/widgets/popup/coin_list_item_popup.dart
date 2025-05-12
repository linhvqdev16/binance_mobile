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
        return Padding(
          padding: EdgeInsets.only(top: index == 0 ? 0 : 15, bottom: 5),
          child: Row(
            children: [
              Image.asset(
                'assets/icons/star.png',
                width: 18,
                height: 18,
                color: ColorStyle.grayColor.withOpacity(0.4),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(fontWeight: FontWeight.w500),
                                children: [
                              TextSpan(
                                text: coin?.symbol.replaceAll("USDT", "") ?? "",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              const TextSpan(
                                text: " /USDT",
                                style: TextStyle(
                                    color: ColorStyle.grayColor, fontSize: 15),
                              ),
                            ])),
                        const SizedBox(height: 2),
                        Text(
                          "KL ${formatNumber(double.parse(coin?.volume.replaceAll(".", "") ?? "0"))}",
                          style: const TextStyle(color: ColorStyle.grayColor),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          ( double.parse(coin?.openPrice ?? '0') + double.parse(coin?.priceChange ?? '0')).toStringAsFixed(2),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${double.parse(coin?.priceChangePercent ?? '0') > 0 ? '+' : ''}${double.parse(coin?.priceChangePercent ?? '0').toStringAsFixed(2)}%',
                          style: TextStyle(
                              color: double.parse(coin?.priceChangePercent ?? '0') >= 0
                                  ? ColorStyle.greenColor
                                  : ColorStyle.redColor),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  String formatNumber(double number) {
    if (number >= 1e9) {
      return '${(number / 1e9).toStringAsFixed(2)}B';
    } else if (number >= 1e6) {
      return '${(number / 1e6).toStringAsFixed(2)}M';
    } else {
      return number.toStringAsFixed(2);
    }
  }
}

/*

ListTile(
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
 */
