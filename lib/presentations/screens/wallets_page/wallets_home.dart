import 'package:binance_mobile/presentations/screens/wallets_page/deposit_page_home/deposit_page_home.dart';
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
              _totalBalanceCardUSTD(screenSize),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              _totalBalanceCardBTC(screenSize),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              _totalBalanceCardBNB(screenSize),
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

  Widget _totalBalanceCardUSTD(Size screenSize) {
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
              children: [
                Image.asset('assets/images/ustd.png', width: 28, height: 28),
                const SizedBox(width: 8),
                const Text('USTD',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(width: 8),
                const Text('Stablecoin',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    )),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Giá gần nhất',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('1 \$',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                    GestureDetector(
                      onTap: () {},
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

  Widget _totalBalanceCardBTC(Size screenSize) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/bitcoin.png',
                        width: 28, height: 28),
                    const SizedBox(width: 8),
                    const Text('BTC ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '+ 131.1 %',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      'Trong 3 năm qua',
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    )
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Giá gần nhất',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('99.433,1 \$',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {},
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

  Widget _totalBalanceCardBNB(Size screenSize) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/binance.png',
                        width: 28, height: 28),
                    const SizedBox(width: 8),
                    const Text('BNB ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '+ 48.49 %',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      'Trong 3 năm qua',
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    )
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Giá gần nhất',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('600,37 \$',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {},
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
