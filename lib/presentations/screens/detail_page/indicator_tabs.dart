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
      height: 40,
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
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: isSelected
                    ? const Border(bottom: BorderSide(color: Colors.amber, width: 2))
                    : null,
              ),
              child: Text(
                indicator,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
