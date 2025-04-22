import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceTracker extends ConsumerStatefulWidget {
  PriceTracker({super.key});

  @override
  ConsumerState<PriceTracker> createState() => _PriceTrackerState();
}

class _PriceTrackerState extends ConsumerState<PriceTracker>
    with SingleTickerProviderStateMixin {
  final WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse('wss://stream.binance.com:9443/ws/!ticker@arr'),
  );

  final List<String> _watchlist = [
    'BNBUSDT',
    'BTCUSDT',
    'ETHUSDT',
    'SOLUSDT',
    'XRPUSDT',
    'REDUSDT',
    'ADAUSDT',
    'PEPEUSDT'
  ];

  final Map<String, dynamic> _tickerData = {};
  final Map<String, double> _prevPrices = {};
  final Map<String, double> _percentChanges = {};
  final Map<String, double> _volumes = {};
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
  bool _isLoading = true;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _channel.stream.listen((message) {
      final decodedMessage = jsonDecode(message);
      setState(() {
        if (_isLoading) {
          _isLoading = false;
        }

        for (var ticker in decodedMessage) {
          final symbol = ticker['s'];
          if (_watchlist.contains(symbol)) {
            final double closePrice = double.parse(ticker['c']);
            final double openPrice = double.parse(ticker['o']);
            final percentChange = ((closePrice - openPrice) / openPrice) * 100;
            final double volume = double.parse(ticker['q']) / 1000000;

            _tickerData[symbol] = closePrice;
            _percentChanges[symbol] = percentChange;
            _volumes[symbol] = volume;

            if (!_prevPrices.containsKey(symbol)) {
              _prevPrices[symbol] = closePrice;
            }
          }
        }
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            for (var ticker in decodedMessage) {
              final symbol = ticker['s'];
              if (_watchlist.contains(symbol)) {
                _prevPrices[symbol] = double.parse(ticker['c']);
              }
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
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
    int selectedTab = 0;

    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _buildHeader(screenSize),
            const SizedBox(height: 5),
            _buildMarketTabs(screenSize),
            const SizedBox(height: 5),
            _buildFilterOptions(screenSize),
            _buildFilterOptions2(screenSize),
            _buildColumnHeaders(screenSize),
            const SizedBox(height: 5),
            _isLoading ? _buildLoadingWidget() : _buildCryptoList(screenSize),
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

//Danh sách yêu thích + Thị trường + Alpha + Phát triển
  Widget _buildMarketTabs(Size screenSize) {
    return Container(
      padding: EdgeInsets.only(top: screenSize.height * 0.015),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: screenSize.width * 0.04),
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
            SizedBox(width: screenSize.width * 0.03),
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
                  SizedBox(width: screenSize.width * 0.03),
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
        SizedBox(width: screenSize.width * 0.02),
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Tên / KL',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Giá gần nhất',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Thay đổi 24h',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

//Dữ liệu
  Widget _buildCryptoList(Size screenSize) {
    return ListView.builder(
      itemCount: _watchlist.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final symbol = _watchlist[index];
        final baseAsset = symbol.replaceAll('USDT', '');
        final price = _tickerData[symbol] ?? 0.0;
        final prevPrice = _prevPrices[symbol] ?? price;
        final percentChange = _percentChanges[symbol] ?? 0.0;
        final volume = _volumes[symbol] ?? 0.0;
        final leverage = _leverages[symbol] ?? 1;

        Color priceColor = price > prevPrice
            ? const Color(0xFF25C26E)
            : (price < prevPrice ? const Color(0xFFF6465D) : Colors.black);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
                      _formatPrice(price),
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
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 75,
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _getChangeColor(percentChange),
                      borderRadius: BorderRadius.circular(7),
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
