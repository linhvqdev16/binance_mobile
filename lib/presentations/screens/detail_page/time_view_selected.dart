import 'package:binance_mobile/core/dependency_injection/injection_container.dart';
import 'package:binance_mobile/core/styles/colors.dart';
import 'package:binance_mobile/core/utils/number_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeViewSelected extends ConsumerWidget {
  const TimeViewSelected({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final periods = ["Thời gian", "15p", "1h", "94h", "1 ngày", "Nhiều hơn"];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 25,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child:  Row(
        // scrollDirection: Axis.horizontal,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
         const Expanded(
            flex: 3,
            child: Text(
              'Thời gian',
              style: TextStyle(
                fontSize: 12,
                color:Colors.grey,
                fontWeight:  FontWeight.normal,
              ),
            ),
          ),
          const Expanded(
              flex: 2,
              child: Text(
            '15p',
            style: TextStyle(
              fontSize: 12,
              color:Colors.grey,
              fontWeight:  FontWeight.normal,
            ),
          )),
          const Expanded(
              flex: 2,
              child: Text(
            '1h',
            style: TextStyle(
              fontSize: 12,
              color:Colors.grey,
              fontWeight:  FontWeight.normal,
            ),
          )),
          const Expanded(
              flex: 2,
              child: Text(
            '4h',
            style: TextStyle(
              fontSize: 12,
              color:Colors.grey,
              fontWeight:  FontWeight.normal,
            ),
          )),
          const Expanded(
              flex: 2,
              child: Text(
            '1 ngày',
            style: TextStyle(
              fontSize: 12,
              color:Colors.grey,
              fontWeight:  FontWeight.normal,
            ),
          )),
          Expanded(
              flex: 4,
              child: Row(
            children: [
              const Text(
                'Nhiều hơn',
                style: TextStyle(
                  fontSize: 12,
                  color:Colors.grey,
                  fontWeight:  FontWeight.normal,
                ),
              ),
              const  SizedBox(width: 10),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  'assets/icons/down-arrow.png',
                  width: 8,
                  height: 8,
                  color: Colors.grey,
                ),
              ),
            ],
          )),
          const Expanded(
              flex: 2,
              child: Text(
            'Độ sâu',
            style: TextStyle(
              fontSize: 12,
              color:Colors.grey,
              fontWeight:  FontWeight.normal,
            ),
          )),
           GestureDetector(
             onTap: () {},
             child: Image.asset(
               'assets/icons/icon_menu.png',
               width: 12,
               height: 12,
               color: Colors.grey,
             ),
           ),
        ],
        // itemCount: periods.length,
        // itemBuilder: (context, index) {
        //   final period = periods[index];
        //   return Container(
        //     margin: const EdgeInsets.only(left: 8),
        //     padding: const EdgeInsets.only(right: 10),
        //     alignment: Alignment.center,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           period,
        //           style: const TextStyle(
        //             fontSize: 12,
        //             color:Colors.grey,
        //             fontWeight:  FontWeight.normal,
        //           ),
        //         ),
        //       ],
        //     ),
        //   );
        // },
      ),
    );
  }
}
