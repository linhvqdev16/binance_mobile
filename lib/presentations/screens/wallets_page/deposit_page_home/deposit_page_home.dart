import 'package:binance_mobile/presentations/screens/wallets_page/deposit_page_home/depositAED.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DipositPageHome extends ConsumerStatefulWidget {
  const DipositPageHome({super.key});

  @override
  ConsumerState<DipositPageHome> createState() => _DipositPageHomeState();
}

class _DipositPageHomeState extends ConsumerState<DipositPageHome>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              buildHeader(screenSize),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: screenSize.width * 0.03),
                child: const Text(
                  'Tôi không có tài sản tiền mã hóa',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const SizedBox(height: 15),
              buildFeatureBox(
                  screenSize: screenSize,
                  imagePath: 'assets/images/lock.png',
                  title: 'Mua với AED',
                  subtitle:
                      'Mua tiền mã hóa dễ dàng thông qua chuyển khoản ngân hàng.',
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DepositAEDPage()),
                        )
                      }),
              const SizedBox(height: 15),
              buildFeatureBox(
                  screenSize: screenSize,
                  imagePath: 'assets/images/p2p.png',
                  title: 'Mua bằng AED (P2P)',
                  subtitle:
                      'Mua từ người dùng. Giá cả cạnh tranh. Thanh toán nội địa.',
                  onTap: () => {}),
              const SizedBox(height: 15),
              buildFeatureBox(
                  screenSize: screenSize,
                  imagePath: 'assets/images/purse.png',
                  title: 'Nhận qua Pay',
                  subtitle: 'Nhận tiền mã hóa từ những người dùng Binance khác',
                  onTap: () => {}),
              const SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.only(left: screenSize.width * 0.03),
                child: const Text(
                  'Tôi có các tài sản tiền mã hóa',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              buildFeatureBox(
                  screenSize: screenSize,
                  imagePath: 'assets/images/lock.png',
                  title: 'Nạp tiền mã hóa',
                  subtitle: 'Gửi tiền mã hóa đến Tài khoản Binance của bạn',
                  onTap: () => {}),
            ],
          ),
        ),
      ),
    );
  }

  //buildHeader
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
            )),
        Container(
          margin: EdgeInsets.only(right: screenSize.width * 0.03),
          padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.02,
              vertical: screenSize.height * 0.001),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
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
            ],
          ),
        )
      ],
    );
  }

  Widget buildFeatureBox({
    required Size screenSize,
    required String imagePath,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
          height: screenSize.height * 0.12,
          width: screenSize.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
            child: Row(
              children: [
                Image.asset(imagePath, height: 31, width: 31),
                SizedBox(width: screenSize.width * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        subtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
