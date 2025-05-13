import 'package:binance_mobile/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinTradingTypePopup extends ConsumerWidget {
  const CoinTradingTypePopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
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
          _buildRowItem(title: "BTC", description: "Dựa trên số lươợng tài sản (BTC, ETH, BNB, v.v.), lệnh sẽ được thực hiện theo số lượng đã chọn nhân với giá tốt nhất hiện có cho cặp tài sản hiện tại."),
          const SizedBox(height: 15,),
          _buildRowItem(title: "USDT", description: "Lệnh sẽ được thực thi dự trên tổng s tiền bạn muốn chi tiêu, bất kể số lượng tài sản (BTC, ETH, BNB, v.v.), là bao nhiêu. "),
          const SizedBox(height: 15,),
          Divider(height: 0.1, color: ColorStyle.grayColor.withOpacity(0.2),),
          const SizedBox(height: 15,),
          GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hủy", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: ColorStyle.blackColor),),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRowItem({required String title, required String description}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: ColorStyle.blackColor),),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(child: Text(description, style: TextStyle(fontWeight: FontWeight.normal, color: ColorStyle.grayColor.withOpacity(0.7), fontSize: 12),))
              ],
            )
        ],
      ),
    );
  }
}
