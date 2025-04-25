import 'package:binance_mobile/data/models/models/market_ticker_model.dart';
import 'package:binance_mobile/presentations/service/home_usecase/market_ticker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesList extends ConsumerStatefulWidget {
  const FavoritesList({super.key});

  @override
  ConsumerState<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends ConsumerState<FavoritesList>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final Map<String, int> _leverages = {
    'BNBUSDT': 10,
    'BTCUSDT': 10,
    'ETHUSDT': 10,
    'SOLUSDT': 5,
    'XRPUSDT': 10,
    'REDUSDT': 5,
    'ADAUSDT': 10,
    'PEPEUSDT': 5
  };
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
    final screenSize = MediaQuery.of(context).size;
    final favoriteData = ref.watch(favoriteProvider);

    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 5),
            _buildFilterOptions(screenSize),
            _buildColumnHeaders(screenSize),
            const SizedBox(height: 5),
            favoriteData.isLoading
                ? _buildLoadingWidget()
                : _buildCryptoList(screenSize, favoriteData),
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
                children: [
                  SizedBox(width: screenSize.width * 0.01),
                  _buildFilter('Tất cả', isSelected: true),
                  _buildFilter('Tài sản'),
                  _buildFilter('Giao ngay'),
                  _buildFilter('Futures'),
                  _buildFilter('Quyền chọn'),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: screenSize.width * 0.02),
        Image.asset(
          'assets/icons/4blacksquares.png',
          width: 15,
          height: 15,
          color: Colors.grey[600],
        ),
        SizedBox(width: screenSize.width * 0.04),
        Image.asset(
          'assets/icons/pen.png',
          width: 15,
          height: 15,
          color: Colors.grey[600],
        ),
        SizedBox(width: screenSize.width * 0.02),
      ],
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
                Text(
                  ' / KL',
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
  Widget _buildCryptoList(Size screenSize, MarketTickerState favoriteData) {
    final marketNotifier = ref.read(favoriteProvider.notifier);
    return ListView.builder(
      itemCount: marketNotifier.watchlist.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final symbol = marketNotifier.watchlist[index];
        final baseAsset = symbol.replaceAll('USDT', '');
        final price = favoriteData.tickerData[symbol] ?? 0.0;
        final prevPrice = favoriteData.prevPrices[symbol] ?? price;
        final percentChange = favoriteData.percentChanges[symbol] ?? 0.0;
        final volume = favoriteData.volumes[symbol] ?? 0.0;
        final leverage = _leverages[symbol] ?? 1;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          baseAsset,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '/USDT ${leverage}x',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${volume.toStringAsFixed(2)}M',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
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
              SizedBox(width: screenSize.width * 0.03),
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
