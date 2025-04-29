import 'package:binance_mobile/presentations/screens/wallets_page/deposit_page_home/deposit_page_home.dart';
import 'package:binance_mobile/presentations/screens/wallets_page/wallets_buy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletsHome extends ConsumerStatefulWidget {
  const WalletsHome({super.key});

  @override
  ConsumerState<WalletsHome> createState() => _WalletsHomeState();
}

class _WalletsHomeState extends ConsumerState<WalletsHome>
    with SingleTickerProviderStateMixin {
  List<String> currencies = ['BTC', 'ETH', 'BNB', 'USDT', 'USD'];
  String selectedCurrency = 'BTC';
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
          child: Column(
            children: [
              _totalBalance(screenSize),
              SizedBox(
                height: screenSize.height * 0.032,
              ),
              _buildBalanceCard(
                screenSize: screenSize,
                imagePath: 'assets/images/ustd.png',
                coinName: 'USTD',
                subTitle: 'Stablecoin',
                price: '1 \$',
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              _buildBalanceCard(
                screenSize: screenSize,
                imagePath: 'assets/images/bitcoin.png',
                coinName: 'BTC',
                growthPercent: '+ 131.1 %',
                growthTime: 'Trong 3 năm qua',
                price: '99.433,1 \$',
              ),
              SizedBox(
                height: screenSize.height * 0.022,
              ),
              _buildBalanceCard(
                screenSize: screenSize,
                imagePath: 'assets/images/binance.png',
                coinName: 'BNB',
                growthPercent: '+ 48.49 %',
                growthTime: 'Trong 3 năm qua',
                price: '600,37 \$',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _totalBalance(Size screenSize) {
    return Padding(
      padding: EdgeInsets.only(top: screenSize.height * 0.03),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Tổng số dư',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.visibility,
                    color: Colors.grey[400],
                    size: 19,
                  ),
                ],
              ),
              Image.asset('assets/icons/conversations.png',
                  width: 28, height: 28),
            ],
          ),
          Row(
            children: [
              const Text(
                '0.00',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 12),
              Column(
                children: [
                  const SizedBox(height: 10),
                  DropdownButton<String>(
                    value: selectedCurrency,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    iconEnabledColor: Colors.grey[500],
                    items: currencies.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCurrency = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DipositPageHome()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xfffad65f),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                elevation: 0,
              ),
              child: const Text(
                'Nạp tiền',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBalanceCard({
    required Size screenSize,
    required String imagePath,
    required String coinName,
    String? subTitle,
    String? growthPercent,
    String? growthTime,
    required String price,
  }) {
    return Container(
      width: screenSize.width,
      height: screenSize.height * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: growthPercent != null
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(imagePath, width: 28, height: 28),
                    const SizedBox(width: 8),
                    Text(
                      coinName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (subTitle != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        subTitle,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
                if (growthPercent != null && growthTime != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        growthPercent,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        growthTime,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13),
                      )
                    ],
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Giá gần nhất',
                    style: TextStyle(color: Colors.black, fontSize: 13)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WalletsBuy()),
                        );
                      },
                      child: const Text(
                        'Mua ngay',
                        style: TextStyle(
                          color: Color(0xfffad65f),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
