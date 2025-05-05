import 'package:flutter/material.dart';

class WalletsBuy extends StatefulWidget {
  const WalletsBuy({super.key});

  @override
  State<WalletsBuy> createState() => _WalletsBuyState();
}

class _WalletsBuyState extends State<WalletsBuy> {
  String amount = '';

  void addDigit(String digit) {
    setState(() {
      if (digit == '.' && amount.contains('.')) return;
      if (amount.isEmpty && digit == '.') {
        amount = '0.';
      } else {
        amount += digit;
      }
    });
  }

  void removeDigit() {
    setState(() {
      if (amount.isNotEmpty) {
        amount = amount.substring(0, amount.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(screenSize),
            buildTextField(screenSize),
            const Spacer(),
            Column(
              children: [
                buildNumberRow(['1', '2', '3']),
                buildNumberRow(['4', '5', '6']),
                buildNumberRow(['7', '8', '9']),
                buildNumberRow(['.', '0', 'backspace']),
              ],
            ),
            const SizedBox(height: 16),
            buildPayment(screenSize),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  //Header widget
  Widget buildHeader(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 28,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: screenSize.width * 0.03),
          padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.02,
              vertical: screenSize.height * 0.001),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: const Icon(
            Icons.book,
            color: Colors.black,
            size: 28,
          ),
        ),
      ],
    );
  }

  //Wiget TextField
  Widget buildTextField(Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.03,
          vertical: screenSize.height * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tôi muốn trả',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Text(
                    'Theo tiền mã hóa',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.swap_horiz, color: Colors.black),
                ],
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.01),
          Container(
            height: screenSize.height * 0.06,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    amount.isEmpty ? 'Hãy nhập số lượng' : amount,
                    style: TextStyle(
                      fontSize: 15,
                      color: amount.isEmpty ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xff038f65),
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        'د.إ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'AED',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.black),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: screenSize.height * 0.02),
          const Text(
            '50,00-99.999.999,00 AED',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }

  // Number pad
  Widget buildNumberRow(List<String> numbers) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: numbers.map((number) {
          if (number == 'backspace') {
            return NumberKey(
              child: const Icon(Icons.backspace),
              onTap: () => removeDigit(),
            );
          }
          return NumberKey(
            child: Text(
              number,
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () => addDigit(number),
          );
        }).toList(),
      ),
    );
  }

  //WidgetPayment
  Widget buildPayment(Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Chọn phương thức thanh toán',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class NumberKey extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const NumberKey({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
