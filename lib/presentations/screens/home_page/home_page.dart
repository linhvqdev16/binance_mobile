import 'package:binance_mobile/core/dependency_injection/injection_container.dart';
import 'package:binance_mobile/presentations/screens/detail_page/detail_page.dart';
import 'package:binance_mobile/presentations/screens/home_page/crypto_list_widget.dart';
import 'package:binance_mobile/presentations/screens/market_page/market_home.dart';
import 'package:binance_mobile/presentations/screens/trade_page/trade_home.dart';
import 'package:binance_mobile/presentations/screens/wallets_page/wallets_home.dart';
import 'package:binance_mobile/presentations/widgets/error/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  final selectedIndexProvider = StateProvider<int>((ref) => 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: unused_local_variable
    final appLocalizations = AppLocalizations.of(context)!;

    // ignore: unused_local_variable
    final selectedIndex = ref.watch(selectedIndexProvider);

    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Chuyển đến màn hình DetailPage khi bấm nút
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => CoinDetailScreen(symbol: 'btc/usdt'),
            //         ),
            //       );
            //     },
            //     child: Text("Go to Detail Page"),
            //   ),
            // ),

            _buildHeader(screenSize),
            _buildBalanceSection(screenSize, context),
            _buildQuickActions(screenSize),
            _buildMarketTabs(screenSize, ref),
            _buildMarketFilters(screenSize),
            _buildHeaderCryptoItem(screenSize),
            _buildMarketList(screenSize, ref),
            Center(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.015),
                child: const Text(
                  'View More',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFFF8F00),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            _buildDiscoveryTabs(screenSize),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.04,
        vertical: screenSize.height * 0.01,
      ),
      child: Row(
        children: [
          Container(
            height: 28,
            width: 28,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(0xFFFFC107),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              'assets/icons/coin.png',
              width: 25,
              height: 25,
            ),
          ),
          SizedBox(width: screenSize.width * 0.03),
          Expanded(
            child: Container(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, size: 18, color: Colors.grey[600]),
                  const SizedBox(width: 3),
                  Text(
                    "🔥 OM",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: screenSize.width * 0.03),
          // Notification Badge
          Stack(
            children: [
              Image.asset(
                'assets/icons/message.png',
                width: 18,
                height: 18,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC107),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: const Text(
                    '14',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: screenSize.width * 0.02),
          // Notification Badge
          Stack(
            children: [
              Image.asset(
                'assets/icons/head_phone.png',
                width: 16,
                height: 16,
              ),
            ],
          ),
          SizedBox(width: screenSize.width * 0.01),
          // Notification Badge
          Stack(
            children: [
              Image.asset(
                'assets/icons/link.png',
                width: 23,
                height: 23,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceSection(Size screenSize, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenSize.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Total Balance (USD)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              Icon(Icons.keyboard_arrow_up, size: 16, color: Colors.grey[600]),
            ],
          ),
          SizedBox(height: screenSize.height * 0.005),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '\$8,54',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.04,
                  vertical: screenSize.height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC107),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Add Funds',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.06,
        vertical: screenSize.height * 0.015,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionItem(Icons.people, 'Refer2Earn', screenSize),
          _buildActionItem(Icons.star_border, 'Rewards Hub', screenSize),
          _buildActionItem(Icons.trending_up, 'Earn', screenSize),
          _buildActionItem(Icons.phone_android, 'MegaApp', screenSize),
          _buildActionItem(Icons.grid_view, 'More', screenSize),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, Size screenSize) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(screenSize.width * 0.025),
          decoration: BoxDecoration(
              // shape: BoxShape.circle,
              border:
                  Border.all(color: Colors.grey.withOpacity(0.15), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: Icon(icon, size: 20, color: Colors.grey[700]),
        ),
        SizedBox(height: screenSize.height * 0.006),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildMarketTabs(Size screenSize, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.only(top: screenSize.height * 0.015),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: screenSize.width * 0.04),
            _buildTab('Favorites', index: 0, ref: ref),
            _buildTab('Hot', index: 1, ref: ref),
            _buildTab('Gainers', index: 2, ref: ref),
            _buildTab('Losers', index: 3, ref: ref),
            _buildTab('New', index: 4, ref: ref),
            _buildTab('24h Vol', index: 5, ref: ref),
            SizedBox(width: screenSize.width * 0.02),
            Icon(Icons.menu, size: 20, color: Colors.grey[700]),
            SizedBox(width: screenSize.width * 0.04),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text,
      {bool isSelected = false, int index = 0, WidgetRef? ref}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => {ref?.read(selectedIndexProvider.notifier).state = index},
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: ref?.watch(selectedIndexProvider) == index
                    ? Colors.black
                    : Colors.grey[500],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 2,
              width: 24,
              color: ref?.watch(selectedIndexProvider) == index
                  ? const Color(0xFFFFC107)
                  : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketFilters(Size screenSize) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.005),
      decoration: const BoxDecoration(
        border: Border(
            // bottom: BorderSide(color: Colors.grey[200]!),
            ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: screenSize.width * 0.04),
          _buildFilter('All', isSelected: true),
          _buildFilter('Spot'),
          _buildFilter('Futures'),
          _buildFilter('Options'),
        ],
      ),
    );
  }

  Widget _buildFilter(String text, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.withOpacity(0.05) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.black : Colors.grey[600],
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMarketList(Size screenSize, WidgetRef ref) {
    final cryptoState = ref.watch(cryptoNotifierProvider);
    if (cryptoState.isLoading) {
      return Container();
    } else if (cryptoState.errorMessage != null) {
      return ErrorMessageWidget(message: cryptoState.errorMessage!);
    } else {
      return CryptoListWidget(
          tickers: cryptoState.tickers, screenSize: screenSize);
    }
  }

  Widget _buildHeaderCryptoItem(Size screenSize) {
    return Container(
      padding: EdgeInsets.only(
        right: screenSize.width * 0.04,
        left: screenSize.width * 0.04,
        bottom: screenSize.width * 0.04,
        top: screenSize.height * 0.007,
      ),
      child: Row(
        children: [
          SizedBox(width: screenSize.width * 0.03),
          Expanded(
            flex: 2,
            child: Text(
              'Name',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
          // Price
          Expanded(
            flex: 2,
            child: Text(
              'Last Price',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(width: screenSize.width * 0.04),
          Expanded(
            flex: 1,
            child: Text(
              '24h chg%',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoveryTabs(Size screenSize) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.015,
        horizontal: screenSize.width * 0.04,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 18,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildDiscoveryTab('Discover', isSelected: true),
                    _buildDiscoveryTab('Following'),
                    _buildDiscoveryTab('News'),
                    _buildDiscoveryTab('Announcement'),
                    _buildDiscoveryTab('Hot'),
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Icon(Icons.menu, size: 20, color: Colors.grey[700]))),
        ],
      ),
    );
  }

  Widget _buildDiscoveryTab(String text, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Text(text,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.black : Colors.grey[500],
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      // onTap: (index) {
      //   setState(() {
      //     _currentIndex = index;
      //   });
      // },
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey.withOpacity(0.5),
      selectedLabelStyle: const TextStyle(fontSize: 12, color: Colors.black),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/house.png',
            width: 25,
            height: 25,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/statistics.png',
            width: 25,
            height: 25,
          ),
          label: 'Markets',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/trade.png',
            width: 25,
            height: 25,
          ),
          label: 'Trade',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/future.png',
            width: 25,
            height: 25,
          ),
          label: 'Futures',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/wallet.png',
            width: 25,
            height: 25,
          ),
          label: 'Wallets',
        ),
      ],
    );
  }
}
