import 'package:binance_mobile/presentations/screens/market_page/favorites_List.dart';
import 'package:binance_mobile/presentations/screens/market_page/market_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarketHome extends ConsumerStatefulWidget {
  const MarketHome({super.key});

  @override
  ConsumerState<MarketHome> createState() => _MarketHomeState();
}

class _MarketHomeState extends ConsumerState<MarketHome>
    with SingleTickerProviderStateMixin {
  final selectedIndexProvider = StateProvider<int>((ref) => 0);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _buildHeader(screenSize),
            const SizedBox(height: 5),
            _buildMarketTabs(screenSize),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

//header
  Widget _buildHeader(Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.03,
        vertical: screenSize.height * 0.01,
      ),
      child: Row(
        children: [
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
                    "Tìm kiếm Coin/Cặp giao dịch/Phái sinh",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: screenSize.width * 0.01),
          Icon(Icons.more_horiz, size: 24, color: Colors.grey[600]),
        ],
      ),
    );
  }

//Danh sách yêu thích + Thị trường + Alpha + Phát triển
  Widget _buildMarketTabs(Size screenSize) {
    return Container(
      padding: EdgeInsets.only(top: screenSize.height * 0.015),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: screenSize.width * 0.02),
            _buildTab('Danh sách yêu thích', index: 0, ref: ref),
            _buildTab('Thị trường', index: 1, ref: ref),
            _buildTab('Alpha', index: 2, ref: ref),
            _buildTab('Phát triển', index: 3, ref: ref),
            _buildTab('Square', index: 4, ref: ref),
            _buildTab('Dữ liệu', index: 5, ref: ref),
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

//tab_change
  Widget _buildTabContent() {
    final selectedIndex = ref.watch(selectedIndexProvider);

    switch (selectedIndex) {
      case 0:
        return const FavoritesList();
      case 1:
        return const MarketPage();

      default:
        return const SizedBox();
    }
  }
}
