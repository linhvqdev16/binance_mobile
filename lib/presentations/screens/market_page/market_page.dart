import 'package:binance_mobile/data/models/models/market_ticker_model.dart';
import 'package:binance_mobile/presentations/riverpod/home_usecase/market_ticker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarketPage extends ConsumerStatefulWidget {
  const MarketPage({super.key});

  @override
  ConsumerState<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends ConsumerState<MarketPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getChangeColor(double change) {
    return change >= 0 ? const Color(0xFF25C26E) : const Color(0xFFF6465D);
  }

  final selectedIndexProvider = StateProvider<int>((ref) => 0);
  @override
  Widget build(BuildContext context) {
    final marketData = ref.watch(marketProvider);
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            _buildFilterOptions(screenSize),
            _buildFilterOptions2(screenSize),
            _buildColumnHeaders(screenSize),
            const SizedBox(height: 5),
            marketData.isLoading
                ? _buildLoadingWidget()
                : _buildCryptoList(screenSize, marketData),
          ],
        ),
      ),
    );
  }

//loadding chờ dữ liệu
  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Sử dụng icon có sẵn của Binance
          RotationTransition(
            turns: _animationController,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFF0B90B),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.currency_bitcoin,
                size: 60,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Binance',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF0B90B),
            ),
          ),
        ],
      ),
    );
  }

//Tiền mã hóa + Giao ngay + USDM + COIN-M + Quyền chọn
  Widget _buildFilterOptions(Size screenSize) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
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
            SizedBox(width: screenSize.width * 0.01),
            _buildFilter('Tiền mã hóa', isSelected: true),
            _buildFilter('Giao ngay'),
            _buildFilter('USDM'),
            _buildFilter('COIN-M'),
            _buildFilter('Quyền chọn'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilter(String text, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: isSelected ? Colors.black : Colors.grey[500],
        ),
      ),
    );
  }

  //Tất cả + solana + RWA + Meme...
  Widget _buildFilterOptions2(Size screenSize) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding:
                  EdgeInsets.symmetric(vertical: screenSize.height * 0.005),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: screenSize.width * 0.015),
                  _buildFilter2('Tất cả', isSelected: true),
                  _buildFilter2('Solana'),
                  _buildFilter2('RWA'),
                  _buildFilter2('Meme'),
                  _buildFilter2('Payments'),
                  _buildFilter2('AI'),
                  _buildFilter2('Lớp 1 / Lớp 2'),
                  _buildFilter2('Metaverse'),
                  _buildFilter2('Hạt giống'),
                  _buildFilter2('Launchpool'),
                  _buildFilter2('Megadrop'),
                  _buildFilter2('Gaming'),
                  _buildFilter2('DeFi'),
                  _buildFilter2('Giám sát'),
                  _buildFilter2('Liquid Staking'),
                  _buildFilter2('Fan Token'),
                  _buildFilter2('Cơ sở hạ tầng'),
                  _buildFilter2('BNB chain'),
                  _buildFilter2('Storage'),
                  _buildFilter2('NFT'),
                  _buildFilter2('Launchpad'),
                  _buildFilter2('Polkadot'),
                  _buildFilter2('POW'),
                  _buildFilter2('Niêm yết mới'),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: screenSize.width * 0.01),
        Icon(Icons.list, size: 25, color: Colors.grey[600]),
        SizedBox(width: screenSize.width * 0.02),
      ],
    );
  }

  Widget _buildFilter2(String text, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.withOpacity(0.05) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: isSelected ? Colors.black : Colors.grey[500],
        ),
      ),
    );
  }

//Tên/KL + giá gần nhất + thay đổi 24h
  Widget _buildColumnHeaders(Size screenSize) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 10, top: 8.0, bottom: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  'Tên',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(width: 1),
                Image.asset(
                  'assets/images/sort.png',
                  width: 10,
                  height: 10,
                  color: Colors.grey[500],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Text(
                  'Giá gần nhất',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(width: 1),
                Image.asset(
                  'assets/images/sort.png',
                  width: 10,
                  height: 10,
                  color: Colors.grey[500],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Thay đổi 24h',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(width: 1),
                Image.asset(
                  'assets/images/sort.png',
                  width: 10,
                  height: 10,
                  color: Colors.grey[500],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//Dữ liệu
  Widget _buildCryptoList(Size screenSize, MarketTickerState marketData) {
    final marketNotifier = ref.read(marketProvider.notifier);
    return ListView.builder(
      itemCount: marketNotifier.watchlist.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final symbol = marketNotifier.watchlist[index];
        final baseAsset = symbol.replaceAll('USDT', '');
        final price = marketData.tickerData[symbol] ?? 0.0;
        final prevPrice = marketData.prevPrices[symbol] ?? price;
        final percentChange = marketData.percentChanges[symbol] ?? 0.0;

        Color priceColor = price > prevPrice
            ? const Color(0xFF25C26E)
            : (price < prevPrice ? const Color(0xFFF6465D) : Colors.black);

        return Container(
          padding:
              const EdgeInsets.only(left: 16.0, right: 10, top: 12, bottom: 12),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  baseAsset,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AnimatedDefaultTextStyle(
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: priceColor,
                      ),
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        _formatPrice(price),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_formatPrice(price)} \$',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenSize.width * 0.02),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 85,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _getChangeColor(percentChange),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      '${percentChange >= 0 ? "+" : ""}${percentChange.toStringAsFixed(2)}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatPrice(double price) {
    if (price == 0) return '0';
    if (price < 0.00001) return price.toStringAsFixed(8);
    if (price < 0.001) return price.toStringAsFixed(6);
    if (price < 1) return price.toStringAsFixed(4);
    if (price < 10) return price.toStringAsFixed(3);
    if (price < 1000) return price.toStringAsFixed(2);
    return price.toStringAsFixed(2);
  }
}
