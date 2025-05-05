import 'package:flutter/material.dart';

class DipositPayScreen extends StatelessWidget {
  const DipositPayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.fullscreen,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pay',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Binance ID: 109 637 339 6',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.copy,
                      size: 16,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              childAspectRatio: 0.85,
              children: [
                _buildPaymentOption(
                    icon: Icons.arrow_upward,
                    label: 'Gửi',
                    iconColor: Colors.black,
                    onTap: () => {}),
                _buildPaymentOption(
                    icon: Icons.arrow_downward,
                    label: 'Nhận',
                    iconColor: Colors.black,
                    onTap: () => {}),
                _buildPaymentOption(
                    icon: Icons.card_giftcard,
                    label: 'Bao lì xì',
                    iconColor: Colors.black,
                    onTap: () => {}),
                _buildPaymentOption(
                    icon: Icons.money,
                    label: 'Gửi tiền\nmật',
                    iconColor: Colors.black,
                    onTap: () => {}),
                _buildPaymentOption(
                    icon: Icons.sync,
                    label: 'Chuyển\nđổi',
                    iconColor: Colors.black,
                    showIndicator: true,
                    onTap: () => {}),
                _buildPaymentOption(
                    icon: Icons.alarm,
                    label: 'Earn tính\nhoạt',
                    iconColor: Colors.black,
                    onTap: () => {}),
                _buildPaymentOption(
                    icon: Icons.send,
                    label: 'Gửi nhiều',
                    iconColor: Colors.black,
                    showIndicator: true,
                    onTap: () => {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String label,
    required Color iconColor,
    bool showIndicator = false,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 24,
                  ),
                ),
                if (showIndicator)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
