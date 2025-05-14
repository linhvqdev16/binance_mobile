import 'package:binance_mobile/core/data/data_origin.dart';
import 'package:binance_mobile/core/styles/colors.dart';
import 'package:binance_mobile/presentations/provider/provider_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomSheetCoinTypeAllWidget extends ConsumerWidget {
  const BottomSheetCoinTypeAllWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        height: 30,
        child: Stack(
          children: [
            ListView(
              scrollDirection: Axis.horizontal,
              children: DataOrigin.filterFutureAllOptions.entries.map((entry) {
                return GestureDetector(
                  onTap: (){
                    ref.read(ProviderCommon.selectedCoinTypeAllOptionsFutureProvider.notifier).state = entry.key;
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      margin:  EdgeInsets.fromLTRB(entry.key == 1 ? 0 : 8, 5,entry.key == 8 ? 0 : 10, 0),
                      decoration: BoxDecoration(
                        color: ref.watch(ProviderCommon.selectedCoinTypeAllOptionsFutureProvider) == entry.key ? ColorStyle.grayColor.withOpacity(0.2) :  Colors.transparent,
                        borderRadius: const BorderRadius.all(Radius.circular(5))
                      ),
                      child: Text(entry.value,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: ref.watch(ProviderCommon.selectedCoinTypeAllOptionsFutureProvider) == entry.key ? ColorStyle.blackColor :  ColorStyle.textDisableColor.withOpacity(0.8)))),
                );
              }).toList(),
            ),
          ],
        ));
  }
}
