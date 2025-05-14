import 'package:binance_mobile/core/styles/colors.dart';
import 'package:binance_mobile/presentations/provider/provider_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_sheet_coin_type_all_widget.dart';
import 'bottom_sheet_search_bar.dart';
import 'bottom_sheet_tab_selector.dart';
import 'coin_list_item_popup.dart';

class CoinBottomFutureSheet extends ConsumerWidget {
  const CoinBottomFutureSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              height: 3,
              width: 40,
              decoration: BoxDecoration(
                  color: ColorStyle.grayColor.withOpacity(0.4),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const SearchBarBottom(),
          const SizedBox(height: 10),
          TabSelector(),
          ref.watch(ProviderCommon.selectedCoinTypeFutureProvider) == 2
              ? const Column(
                  children: [
                    SizedBox(height: 10),
                    BottomSheetCoinTypeAllWidget()
                  ],
                )
              : const SizedBox(height: 0),
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
                      const Text(
                        "Tên",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: ColorStyle.grayColor),
                      ),
                      Stack(
                        children: [
                          Icon(Icons.arrow_drop_down_outlined,
                              color: ColorStyle.grayColor.withOpacity(0.5)),
                          Positioned(
                              bottom: 7,
                              child: Icon(Icons.arrow_drop_up_outlined,
                                  color:
                                      ColorStyle.grayColor.withOpacity(0.5))),
                        ],
                      ),
                      const Text(
                        "/",
                        style: TextStyle(color: ColorStyle.grayColor),
                      ),
                      const Text(
                        " KL",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: ColorStyle.grayColor),
                      ),
                      Stack(
                        children: [
                          Icon(Icons.arrow_drop_down_outlined,
                              color: ColorStyle.grayColor.withOpacity(0.5)),
                          Positioned(
                              bottom: 7,
                              child: Icon(Icons.arrow_drop_up_outlined,
                                  color:
                                      ColorStyle.grayColor.withOpacity(0.5))),
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
                      const Text(
                        "Giá gần nhất",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: ColorStyle.grayColor),
                      ),
                      Stack(
                        children: [
                          Icon(Icons.arrow_drop_down_outlined,
                              color: ColorStyle.grayColor.withOpacity(0.5)),
                          Positioned(
                              bottom: 7,
                              child: Icon(Icons.arrow_drop_up_outlined,
                                  color:
                                      ColorStyle.grayColor.withOpacity(0.5))),
                        ],
                      ),
                      const Text(
                        "/",
                        style: TextStyle(color: ColorStyle.grayColor),
                      ),
                      const Text(
                        " Bđ gần nhất",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: ColorStyle.grayColor),
                      ),
                      Stack(
                        children: [
                          Icon(Icons.arrow_drop_down_outlined,
                              color: ColorStyle.grayColor.withOpacity(0.5)),
                          Positioned(
                              bottom: 7,
                              child: Icon(Icons.arrow_drop_up_outlined,
                                  color:
                                      ColorStyle.grayColor.withOpacity(0.5))),
                        ],
                      ),
                      Image.asset(
                        'assets/icons/compare_arrow.png',
                        width: 15,
                        height: 15,
                        color: ColorStyle.textDisableColor,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: ref.watch(ProviderCommon.selectedCoinTypeFutureProvider) ==
                    2
                ? MediaQuery.of(context).size.height * 0.665
                : MediaQuery.of(context).size.height * 0.715, // Cho scroll được
            child: const CoinListItemPopup(),
          ),
        ],
      ),
    );
  }
}
