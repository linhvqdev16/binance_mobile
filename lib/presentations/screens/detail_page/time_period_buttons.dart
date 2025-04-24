import 'package:binance_mobile/core/dependency_injection/injection_container.dart';
import 'package:binance_mobile/core/styles/colors.dart';
import 'package:binance_mobile/core/utils/number_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimePeriodButtons extends ConsumerWidget {
  const TimePeriodButtons({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marketPercentModel = ref.watch(marketPercentProvider);
    final periods = ["Hôm nay", "7 ngày", "30 ngày", "90 ngày", "180 ngày", "1 năm"];
    final percentages = ["${NumberFormatterCustom.formatPrice(marketPercentModel.h24)}%",
      "${NumberFormatterCustom.formatPrice(marketPercentModel.d7)}%",
      "${NumberFormatterCustom.formatPrice(marketPercentModel.d30)}%",
      "${NumberFormatterCustom.formatPrice(marketPercentModel.d90)}%",
      "${NumberFormatterCustom.formatPrice(marketPercentModel.d180)}%",
      "${NumberFormatterCustom.formatPrice(marketPercentModel.y1)}%"];
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: periods.length,
        itemBuilder: (context, index) {
          final period = periods[index];
          final percentage = percentages[index];
          final isPositive = !percentage.contains('-');
          return Container(
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  period,
                  style: const TextStyle(
                    fontSize: 11,
                    color:Colors.grey,
                    fontWeight:  FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  percentage,
                  style: TextStyle(
                    color: isPositive ? ColorStyle.greenColor : ColorStyle.redColor,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
