import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DepositCryptoPage extends ConsumerStatefulWidget {
  const DepositCryptoPage({super.key});

  @override
  ConsumerState<DepositCryptoPage> createState() => _DepositCryptoPageState();
}

class _DepositCryptoPageState extends ConsumerState<DepositCryptoPage> {
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(screenSize),
            Expanded(child: buildListCrypto(screenSize)),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            iconSize: 27,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Lựa chọn Coin',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListCrypto(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey.shade500,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Hãy nhập từ khóa',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: const Text(
            'Xu hướng',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
                color: Colors.black87),
          ),
        ),
        SizedBox(height: size.height * 0.005),
        Expanded(
          child: Stack(
            children: [
              ListView.builder(
                itemCount: cryptoList.length,
                itemBuilder: (context, index) {
                  final crypto = cryptoList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 16,
                      backgroundColor: crypto['iconColor'],
                      child: Icon(
                        crypto['icon'],
                        color: Colors.white,
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          crypto['symbol'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              fontSize: 16),
                        ),
                        SizedBox(width: size.width * 0.01),
                        if (crypto['isVerified'])
                          const Icon(Icons.verified,
                              color: Colors.amber, size: 16),
                      ],
                    ),
                    subtitle: Text(
                      crypto['name'],
                      style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12.5,
                          color: Colors.grey),
                    ),
                    onTap: () {
                      this.setState(() {
                        // selectedCrypto = crypto['symbol'];
                        // selectedCryptoFullName = crypto['name'];
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
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
                                fontSize: 13,
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
    );
  }
}
