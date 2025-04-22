import 'package:flutter/material.dart';

class TimePeriodButtons extends StatefulWidget {
  const TimePeriodButtons({super.key});

  @override
  State<TimePeriodButtons> createState() => _TimePeriodButtonsState();
}

class _TimePeriodButtonsState extends State<TimePeriodButtons> {
  int _selectedIndex = 5; // "1 năm" is selected by default

  @override
  Widget build(BuildContext context) {
    final periods = ["Hôm nay", "7 ngày", "30 ngày", "90 ngày", "180 ngày", "1 năm"];
    final percentages = ["3,33%", "3,80%", "3,95%", "-18,06%", "30,53%", "35,04%"];

    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: periods.length,
        itemBuilder: (context, index) {
          final period = periods[index];
          final percentage = percentages[index];
          final isSelected = index == _selectedIndex;
          final isPositive = !percentage.contains('-');

          return InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: isSelected
                    ? const Border(bottom: BorderSide(color: Colors.amber, width: 2))
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    period,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.grey,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    percentage,
                    style: TextStyle(
                      color: isPositive ? Colors.green : Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
