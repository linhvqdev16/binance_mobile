import 'package:flutter/material.dart';

class IndicatorTabs extends StatefulWidget {
  const IndicatorTabs({super.key});

  @override
  State<IndicatorTabs> createState() => _IndicatorTabsState();
}

class _IndicatorTabsState extends State<IndicatorTabs> {
  int _selectedIndex = 4; // VOL is selected by default

  @override
  Widget build(BuildContext context) {
    final indicators = ["MA", "EMA", "BOLL", "SAR", "AVL", "VOL", "MACD", "RSI", "KDJ"];

    return SizedBox(
      height: 20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: indicators.length + 1, // +1 for the last icon
        itemBuilder: (context, index) {
          if (index == indicators.length) {
            return IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            );
          }
          final indicator = indicators[index];
          final isSelected = index == _selectedIndex;
          return InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.center,
              child: Text(
                indicator,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.grey,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
