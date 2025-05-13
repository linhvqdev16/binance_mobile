import 'package:binance_mobile/core/data/data_origin.dart';
import 'package:binance_mobile/core/styles/colors.dart';
import 'package:binance_mobile/presentations/provider/provider_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BidFormPopup extends ConsumerWidget{
  const BidFormPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.38,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      decoration: const BoxDecoration(
          color: ColorStyle.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Center(
            child: Container(
              height: 3,
              width: 40,
              decoration: BoxDecoration(
                  color: ColorStyle.grayColor.withOpacity(0.4),
                  borderRadius: const BorderRadius.all(Radius.circular(12))
              ),
            ),
          ),
          const SizedBox(height: 15,),
          Expanded(child: ListView(
            scrollDirection: Axis.vertical,
            children: DataOrigin.bidFormPopupTypes.entries.map((item){
              return GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  ref.read(ProviderCommon.selectedBidFormPopupProvider.notifier).state = item.key;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
                      ref.watch(ProviderCommon.selectedBidFormPopupProvider) == item.key ?  const Icon(Icons.check_rounded, weight: 5.0,) : const SizedBox(height: 0)
                    ],
                  ),
                ),
              );
            }).toList(),
          ))

        ],
      ),
    );
  }

}