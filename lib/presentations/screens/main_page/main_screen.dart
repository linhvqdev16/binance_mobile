import 'package:binance_mobile/core/dependency_injection/injection_container.dart';
import 'package:binance_mobile/presentations/screens/home_page/home_page.dart';
import 'package:binance_mobile/presentations/screens/market_page/market_home.dart';
import 'package:binance_mobile/presentations/screens/detail_page/detail_page.dart';
import 'package:binance_mobile/presentations/screens/trade_page/trade_home.dart';
import 'package:binance_mobile/presentations/screens/wallets_page/wallets_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  MainPage({super.key});

  final selectedIndexProvider = StateProvider<int>((ref) => 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    final List<Widget> _screens = [
      const TradeHome(), // HomePage(),
      const MarketHome(),
      const TradeHome(),
      const Center(
        child: Text('Đây là màn Futures'),
      ),
      // const CoinDetailScreen(symbol: 'btc/usdt'),
      const WalletsHome()
    ];
    return Scaffold(
      body: _screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          ref.read(selectedIndexProvider.notifier).state = index;
        },
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
      ),
    );
  }
}
