import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinPriceHeader extends ConsumerWidget {
  final String symbol;

  CoinPriceHeader({super.key, required this.symbol});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/left_arrow.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    symbol,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/down-arrow.png',
                      width: 10,
                      height: 10,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/star.png',
                      width: 15,
                      height: 15,
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/share.png',
                      width: 15,
                      height: 15,
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/grid.png',
                      width: 15,
                      height: 15,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
