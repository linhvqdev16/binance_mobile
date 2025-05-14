import 'package:binance_mobile/core/styles/colors.dart';
import 'package:flutter/material.dart';

class SearchBarBottom extends StatelessWidget {
  const SearchBarBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, size: 18, color: ColorStyle.textDisableColor),
                SizedBox(width: 3),
                Text(
                  "Tìm",
                  style: TextStyle(
                      color: ColorStyle.textDisableColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15,),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Image.asset(
                'assets/icons/icon_fluaction.png',
                width: 25,
                height: 25,
              ),
              const SizedBox(width: 3),
              const Text(
                "Top biến động",
                style: TextStyle(
                    color: ColorStyle.blackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}