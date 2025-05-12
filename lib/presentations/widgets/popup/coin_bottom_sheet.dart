import 'package:binance_mobile/core/styles/colors.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet_search_bar.dart';
import 'bottom_sheet_tab_selector.dart';
import 'coin_list_item_popup.dart';

class CoinBottomSheet extends StatelessWidget {
  const CoinBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SearchBarBottom(),
          const SizedBox(height: 10),
          TabSelector(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Tên",  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: ColorStyle.grayColor),),
                      Stack(
                        children: [
                          Icon(Icons.arrow_drop_down_outlined,  color: ColorStyle.grayColor.withOpacity(0.5)),
                          Positioned(
                              bottom: 7,
                              child: Icon(Icons.arrow_drop_up_outlined,  color: ColorStyle.grayColor.withOpacity(0.5))),
                        ],
                      ),
                      const Text("/", style: TextStyle( color: ColorStyle.grayColor),),
                      const Text(" KL",  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: ColorStyle.grayColor),),
                      Stack(
                        children: [
                          Icon(Icons.arrow_drop_down_outlined,  color: ColorStyle.grayColor.withOpacity(0.5)),
                          Positioned(
                              bottom: 7,
                              child: Icon(Icons.arrow_drop_up_outlined,  color: ColorStyle.grayColor.withOpacity(0.5))),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Giá gần nhất",  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: ColorStyle.grayColor),),
                      Stack(
                        children: [
                          Icon(Icons.arrow_drop_down_outlined,  color: ColorStyle.grayColor.withOpacity(0.5)),
                          Positioned(
                              bottom: 7,
                              child: Icon(Icons.arrow_drop_up_outlined,  color: ColorStyle.grayColor.withOpacity(0.5))),
                        ],
                      ),
                      const Text("/", style: TextStyle( color: ColorStyle.grayColor),),
                      const Text(" Bđ gần nhất", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: ColorStyle.grayColor),),
                      Stack(
                        children: [
                          Icon(Icons.arrow_drop_down_outlined, color: ColorStyle.grayColor.withOpacity(0.5)),
                          Positioned(
                              bottom: 7,
                              child: Icon(Icons.arrow_drop_up_outlined, color:  ColorStyle.grayColor.withOpacity(0.5))),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75, // Cho scroll được
            child: const CoinListItemPopup(),
          ),
        ],
      ),
    );
  }
}
