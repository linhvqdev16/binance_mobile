import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DipositP2PScreen extends ConsumerStatefulWidget {
  const DipositP2PScreen({super.key});

  @override
  ConsumerState<DipositP2PScreen> createState() => _DipositP2PScreenState();
}

class _DipositP2PScreenState extends ConsumerState<DipositP2PScreen> {
  List<String> listPrice = [
    'USDT',
    'BTC',
  ];
  String selectedPrice = "USDT";
  List<String> listMoney = ['Số tiền'];
  String selectedMoney = "Số tiền";
  List<String> listPay = ['Thanh toán'];
  String selectedPay = "Thanh toán";
  bool isBuy = true;

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
            SizedBox(height: screenSize.height * 0.035),
            _buildToggleButton(screenSize),
            SizedBox(height: screenSize.height * 0.035),
            Expanded(child: _buildItemBloc()),
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
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text(
                  'GIAO DỊCH NHANH',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(width: screenSize.width * 0.04),
                Text(
                  'P2P',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(width: screenSize.width * 0.04),
                Text(
                  'Giao dịch lô',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        )),
        Padding(
          padding: EdgeInsets.only(right: screenSize.width * 0.02),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade900),
            ),
            child: const Row(
              children: [
                Text(
                  'AED',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.arrow_drop_down, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //WidgetBuy_Sell
  Widget _buildBuySellWidget(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
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
                            fontFamily: 'Roboto',
                            color: isBuy ? Colors.white : Colors.black54,
                            fontWeight: FontWeight.bold,
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
                            fontFamily: 'Roboto',
                            color: !isBuy ? Colors.white : Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: screenSize.width * 0.02),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notification_add_rounded,
                  color: Colors.black, size: 28),
              Positioned(
                top: -1,
                right: 3,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //_buildToggleButton
  Widget _buildToggleButton(screenSize) {
    return Padding(
      padding: EdgeInsets.only(
          left: screenSize.width * 0.03, right: screenSize.width * 0.02),
      child: Row(
        children: [
          Image.asset(
            'assets/images/ustd.png',
            width: 23,
            height: 23,
            fit: BoxFit.cover,
          ),
          SizedBox(width: screenSize.width * 0.03),
          DropdownButton<String>(
            value: selectedPrice,
            style: const TextStyle(
              fontFamily: 'Roboto',
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            iconEnabledColor: Colors.grey[500],
            items: listPrice.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedPrice = newValue!;
              });
            },
          ),
          SizedBox(width: screenSize.width * 0.03),
          DropdownButton<String>(
            value: selectedMoney,
            style: const TextStyle(
              fontFamily: 'Roboto',
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            iconEnabledColor: Colors.grey[500],
            items: listMoney.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedMoney = newValue!;
              });
            },
          ),
          SizedBox(width: screenSize.width * 0.03),
          DropdownButton<String>(
            value: selectedPay,
            style: const TextStyle(
              fontFamily: 'Roboto',
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            iconEnabledColor: Colors.grey[500],
            items: listPay.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedPay = newValue!;
              });
            },
          ),
          const Spacer(),
          Image.asset('assets/images/filter.png',
              width: 20, height: 20, fit: BoxFit.cover),
        ],
      ),
    );
  }

  //item bloc

  Widget _buildItemBloc() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: [
        _buildOfferCard(
          username: "Global-Trader-OTC",
          verifiedStatus: true,
          orderCount: "3534",
          completionRate: "100.00%",
          price: "3,868",
          currency: "AED",
          minMax: "1.000.000 - 50.000.000 AED",
          availableAmount: "40.343,99 USDT",
          timeLimit: "15 phút",
          isVerified: true,
          showBuyButton: false,
          isOutstanding: true,
        ),
        const SizedBox(height: 16),
        _buildOfferCard(
            username: "A-HEGOO",
            verifiedStatus: false,
            orderCount: "150",
            completionRate: "96.80%",
            price: "3,683",
            currency: "AED",
            minMax: "10.000.000 - 12.549.000 AED",
            availableAmount: "3.407,51 USDT",
            timeLimit: "15 phút",
            isVerified: false,
            showBuyButton: true,
            isOutstanding: false),
      ],
    );
  }

  Widget _buildOfferCard({
    required String username,
    required bool verifiedStatus,
    required String orderCount,
    required String completionRate,
    required String price,
    required String currency,
    required String minMax,
    required String availableAmount,
    required String timeLimit,
    required bool isVerified,
    required bool showBuyButton,
    required bool isOutstanding,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      decoration: BoxDecoration(
        border: isOutstanding ? Border.all(color: Colors.amber.shade200) : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              if (isOutstanding)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: const BoxDecoration(
                    color: Color(0xfffcf7e8),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                  ),
                  child: const Text(
                    "Nổi bật",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),
                  ),
                )
              else
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 14,
                  child: Icon(Icons.person, size: 18, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Text(
                  username,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
                const SizedBox(width: 4),
                if (verifiedStatus)
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.favorite,
                        color: Colors.white, size: 10),
                  ),
                const SizedBox(width: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Pro',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text(
                  "Lệnh: $orderCount ($completionRate)",
                  style: const TextStyle(
                      fontFamily: 'Roboto', fontSize: 11, color: Colors.grey),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.thumb_up, size: 10, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text(
                        completionRate,
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 10,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "/$currency",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style:
                            const TextStyle(fontFamily: 'Roboto', fontSize: 11),
                        children: [
                          const TextSpan(
                            text: 'Giới hạn: ',
                            style: TextStyle(
                                fontFamily: 'Roboto', color: Colors.grey),
                          ),
                          TextSpan(
                            text: minMax,
                            style: const TextStyle(
                                fontFamily: 'Roboto', color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Text('Chuyển khoản ngân hàng',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 11,
                            color: Colors.black)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style:
                            const TextStyle(fontFamily: 'Roboto', fontSize: 11),
                        children: [
                          const TextSpan(
                            text: 'Khả dụng: ',
                            style: TextStyle(
                                fontFamily: 'Roboto', color: Colors.grey),
                          ),
                          TextSpan(
                            text: availableAmount,
                            style: const TextStyle(
                                fontFamily: 'Roboto', color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 12, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          timeLimit,
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isVerified)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Text(
                          "Xác minh",
                          style: TextStyle(fontFamily: 'Roboto', fontSize: 12),
                        ),
                      ),
                    ],
                  )
                else
                  Container(),
                if (showBuyButton)
                  Container(
                    width: 90,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Center(
                      child: Text(
                        "Mua",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Text(
                      "Có hạn chế >>",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.grey,
                          fontSize: 12),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
