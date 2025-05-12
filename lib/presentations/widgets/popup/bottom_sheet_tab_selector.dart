import 'package:binance_mobile/core/styles/colors.dart';
import 'package:binance_mobile/presentations/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabSelector extends ConsumerWidget {
  TabSelector({super.key});

  final Map<int, String> filterOptions = {
    1: 'Danh sách yêu thích',
    2: 'Tài sản',
    3: 'Mới',
    4: 'USDT',
    5: 'USDC',
    6: 'FDUSD',
    7: 'BNB',
    8: 'BTC',
    9: 'ALTS',
    10: 'FIAT',
    11: 'Zone'
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        height: 36,
        child: Stack(
          children: [
             Align(
              alignment: Alignment.bottomCenter,
              child: Divider(
                height: 1,
                color: ColorStyle.grayColor.withOpacity(0.3),
              ),
            ),
            ListView(
              scrollDirection: Axis.horizontal,
              children: filterOptions.entries.map((entry) {
                final isSelected = entry.key == 1;
                return GestureDetector(
                  onTap: (){
                    ref.read(selectedCoinItemProvider.notifier).state = entry.key;
                  },
                  child: Padding(
                      padding:  EdgeInsets.fromLTRB(entry.key == 1 ? 0 : 10, 5,entry.key == 11 ? 0 : 10, 0),
                      child: Column(
                        children: [
                          Text(entry.value,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: ref.watch(selectedCoinItemProvider) == entry.key ? ColorStyle.blackColor :  ColorStyle.grayColor.withOpacity(0.8))),
                          const SizedBox(height: 5),
                          AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 2,
                              width: ref.watch(selectedCoinItemProvider) == entry.key ? 20 : 0,
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
