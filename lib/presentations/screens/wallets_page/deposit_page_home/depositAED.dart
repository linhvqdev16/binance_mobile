import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DepositAEDPage extends ConsumerStatefulWidget {
  const DepositAEDPage({super.key});

  @override
  ConsumerState<DepositAEDPage> createState() => _DepositAEDPageState();
}

class _DepositAEDPageState extends ConsumerState<DepositAEDPage> {
  String amount = "0";
  bool isBuy = true;
  String selectedCrypto = "USDT";
  String selectedCryptoFullName = "TetherUS";

  final List<Map<String, dynamic>> cryptoList = [
    {
      'symbol': 'USDT',
      'name': 'TetherUS',
      'icon': Icons.monetization_on,
      'iconColor': Colors.teal,
      'isVerified': true,
    },
    {
      'symbol': 'USDC',
      'name': 'USDC',
      'icon': Icons.monetization_on,
      'iconColor': Colors.blue,
      'isVerified': true,
    },
    {
      'symbol': 'TRUMP',
      'name': 'OFFICIAL TRUMP',
      'icon': Icons.stars,
      'iconColor': Colors.amber,
      'isVerified': true,
    },
    {
      'symbol': 'BTC',
      'name': 'Bitcoin',
      'icon': Icons.currency_bitcoin,
      'iconColor': Colors.orange,
      'isVerified': true,
    },
    {
      'symbol': 'ETH',
      'name': 'Ethereum',
      'icon': Icons.auto_awesome,
      'iconColor': Colors.purple,
      'isVerified': true,
    },
    {
      'symbol': 'EURI',
      'name': 'Eurite',
      'icon': Icons.euro,
      'iconColor': Colors.teal,
      'isVerified': true,
    },
    {
      'symbol': 'SOLV',
      'name': 'Solv Protocol',
      'icon': Icons.flash_on,
      'iconColor': Colors.deepPurple,
      'isVerified': true,
    },
    {
      'symbol': '1000CAT',
      'name': '1000*Simons Cat',
      'icon': Icons.pets,
      'iconColor': Colors.red,
      'isVerified': false,
    },
    {
      'symbol': '1000CHEEMS',
      'name': '1000*cheems.pet',
      'icon': Icons.emoji_nature,
      'iconColor': Colors.brown,
      'isVerified': false,
    },
  ];

  //Modal danh sách tiền mã hóa
  void _showCryptoListBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Danh sách tiền mã hóa',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.grey.shade500,
                            size: 10,
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Tìm',
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Huỷ bỏ',
                              style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Tất cả tiền mã hóa',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // List of cryptocurrencies
                  Expanded(
                    child: Stack(
                      children: [
                        ListView.builder(
                          itemCount: cryptoList.length,
                          itemBuilder: (context, index) {
                            final crypto = cryptoList[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: crypto['iconColor'],
                                child:
                                    Icon(crypto['icon'], color: Colors.white),
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    crypto['symbol'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  if (crypto['isVerified'])
                                    const Icon(Icons.verified,
                                        color: Colors.amber, size: 16),
                                ],
                              ),
                              subtitle: Text(crypto['name']),
                              onTap: () {
                                this.setState(() {
                                  selectedCrypto = crypto['symbol'];
                                  selectedCryptoFullName = crypto['name'];
                                });
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),

                        // Alphabet index on the right
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            width: 20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                '1',
                                'A',
                                'B',
                                'C',
                                'D',
                                'E',
                                'F',
                                'G',
                                'H',
                                'I',
                                'J',
                                'K',
                                'L',
                                'M',
                                'N',
                                'O',
                                'P',
                                'Q',
                                'R',
                                'S',
                                'T',
                                'U',
                                'V',
                                'W',
                                'X',
                                'Y',
                                'Z'
                              ]
                                  .map((letter) => Text(
                                        letter,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey.shade600,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(screenSize),
            SizedBox(height: screenSize.height * 0.015),
            _buildBuySellWidget(screenSize),
            SizedBox(height: screenSize.height * 0.015),
            _buildPriceChange(screenSize),
            SizedBox(height: screenSize.height * 0.015),
            _buildBuyCoin(screenSize),
            SizedBox(height: screenSize.height * 0.015),
            _buildPayment(screenSize),
            SizedBox(height: screenSize.height * 0.015),
            _buildAmountButtons(screenSize),
            Expanded(
              child: numericKeypad(
                onKeyPressed: (value) {
                  setState(() {
                    if (value == 'Del') {
                      if (amount.length > 1) {
                        amount = amount.substring(0, amount.length - 1);
                      } else {
                        amount = '0';
                      }
                    } else if (amount == '0' && value != '.') {
                      amount = value;
                    } else {
                      if (value == '.' && amount.contains('.')) {
                        return;
                      }
                      amount += value;
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //buildHeader
  Widget _buildHeader(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 28,
            )),
        Padding(
          padding: EdgeInsets.only(right: screenSize.width * 0.02),
          child: const Icon(Icons.book, color: Colors.black, size: 25),
        ),
      ],
    );
  }

  //WidgetBuy_Sell
  Widget _buildBuySellWidget(Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
      child: Container(
        width: screenSize.width * 0.3,
        height: screenSize.height * 0.05,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isBuy = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: isBuy ? Colors.black : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'Mua',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: isBuy ? Colors.white : Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        fontSize: 14),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isBuy = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: !isBuy ? Colors.black : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'Bán',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: !isBuy ? Colors.white : Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Thay đổi giá
  Widget _buildPriceChange(Size screenSize) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text(
                  amount,
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[400]),
                ),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'AED',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.arrow_drop_down, size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Row(
            children: [
              Icon(Icons.swap_vert, size: 15, color: Colors.black),
              SizedBox(width: 8),
              Text(
                '0 USDT',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //Mua tiền mã hóa
  Widget _buildBuyCoin(Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: ListTile(
          leading: Image.asset(
            'assets/images/ustd.png',
            width: 28,
            height: 28,
          ),
          title: const Text(
            'Mua',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                selectedCrypto,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.verified, color: Colors.amber, size: 16),
            ],
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.grey[400],
            size: 20,
          ),
          onTap: _showCryptoListBottomSheet,
        ),
      ),
    );
  }

  //Thanh toán
  Widget _buildPayment(Size screenSize) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: ListTile(
        leading: const Icon(Icons.account_balance, color: Colors.black),
        title: const Text(
          'Thanh toán bằng',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        subtitle: const Text(
          'Chuyển khoản ngân hàng',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey[400],
          size: 20,
        ),
      ),
    );
  }

  //Quick amount buttons
  Widget _buildAmountButtons(Size screenSize) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          // Quick amount buttons row
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      amount = "70";
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: const Text('70 đ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      amount = "200";
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: const Text('200 đ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      amount = "1000";
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Tối đa',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Numeric Keypad Widget
  Widget numericKeypad({required Function(String) onKeyPressed}) {
    Widget buildKeypadButton(String value) {
      return InkWell(
        onTap: () => onKeyPressed(value),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 2.5,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        buildKeypadButton('1'),
        buildKeypadButton('2'),
        buildKeypadButton('3'),
        buildKeypadButton('4'),
        buildKeypadButton('5'),
        buildKeypadButton('6'),
        buildKeypadButton('7'),
        buildKeypadButton('8'),
        buildKeypadButton('9'),
        buildKeypadButton('.'),
        buildKeypadButton('0'),
        buildKeypadButton('Del'),
      ],
    );
  }
}
