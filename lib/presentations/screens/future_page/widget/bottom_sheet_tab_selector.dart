import 'package:binance_mobile/core/data/data_origin.dart';
import 'package:binance_mobile/core/styles/colors.dart';
import 'package:binance_mobile/presentations/provider/provider_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabSelector extends ConsumerWidget {
  TabSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        height: 36,
        child: Stack(
          children: [
             Align(
              alignment: Alignment.bottomCenter,
              child: Divider(
                height: 0.1,
                color: ColorStyle.grayColor.withOpacity(0.1),
              ),
            ),
            ListView(
              scrollDirection: Axis.horizontal,
              children: DataOrigin.filterFutureOptions.entries.map((entry) {
                return GestureDetector(
                  onTap: (){
                    ref.read(ProviderCommon.selectedCoinTypeFutureProvider.notifier).state = entry.key;
                  },
                  child: Padding(
                      padding:  EdgeInsets.fromLTRB(entry.key == 1 ? 0 : 10, 5,entry.key == 11 ? 0 : 10, 0),
                      child: Column(
                        children: [
                          Text(entry.value,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ref.watch(ProviderCommon.selectedCoinTypeFutureProvider) == entry.key ? ColorStyle.blackColor :  ColorStyle.textDisableColor.withOpacity(0.8))),
                          const SizedBox(height: 9),
                          AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 2,
                              width: ref.watch(ProviderCommon.selectedCoinTypeFutureProvider) == entry.key ? 20 : 0,
                              decoration: BoxDecoration(
                                color: Colors.yellow[700],
                                borderRadius: BorderRadius.circular(2),
                              )),
                        ],
                      )),
                );
              }).toList(),
            ),
          ],
        ));
  }
}
