import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final tabs = ['USDT', 'USDC', 'FDUSD', 'BNB'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: tabs.map((tab) {
        return Text(
          tab,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: tab == 'USDT' ? Colors.orange : Colors.grey,
          ),
        );
      }).toList(),
    );
  }
}
