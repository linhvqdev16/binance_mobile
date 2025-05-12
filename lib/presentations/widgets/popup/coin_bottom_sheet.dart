import 'package:flutter/material.dart';

import 'bottom_sheet_search_bar.dart';
import 'bottom_sheet_tab_selector.dart';
import 'coin_list_item_popup.dart';

class CoinBottomSheet extends StatelessWidget {
  const CoinBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height * 0.92,
      padding: const EdgeInsets.fromLTRB(12,12,12,0),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SearchBarBottom(),
          const SizedBox(height: 10),
          TabSelector(),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.81, // Cho scroll được
            child: const CoinListItemPopup(),
          ),
        ],
      ),
    );
  }
}
