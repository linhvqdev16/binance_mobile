import 'package:binance_mobile/core/data/data_origin.dart';
import 'package:binance_mobile/core/dependency_injection/injection_container.dart';
import 'package:binance_mobile/core/styles/colors.dart';
import 'package:binance_mobile/data/models/models/market_data_model.dart';
import 'package:binance_mobile/data/models/models/order_book_data.dart';
import 'package:binance_mobile/presentations/provider/provider_common.dart';
import 'package:binance_mobile/presentations/widgets/popup/bid_form_popup.dart';
import 'package:binance_mobile/presentations/widgets/popup/coin_bottom_sheet.dart';
import 'package:binance_mobile/presentations/widgets/popup/coin_trading_type_popup.dart';
import 'package:binance_mobile/presentations/widgets/popup/oco_limit_or_maket_popup.dart';
import 'package:binance_mobile/presentations/widgets/popup/spot_type_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FuturePage extends ConsumerStatefulWidget {
  const FuturePage({super.key});

  @override
  ConsumerState<FuturePage> createState() => _FuturePageState();
}

final numberFormat = NumberFormat("#,##0.0", "en_US");
final selectedSpotTypeProvider = StateProvider<int>((ref) => 1);
final selectedCoinTradingTypeProvider = StateProvider<int>((ref) => 1);

class _FuturePageState extends ConsumerState<FuturePage>
    with SingleTickerProviderStateMixin {
  final selectedIndexProvider = StateProvider<int>((ref) => 0);
  final selectedTabIndexProvider = StateProvider<int>((ref) => 0);
  final isBuySelectedProvider = StateProvider<bool>((ref) => true);
  bool isBuySelected = true;
  late final int currentStep = 0;
  late final int totalSteps = 5;

  /// Tổng số coin
  final TextEditingController _controllerTotalCoin = TextEditingController();
  final FocusNode _focusNodeTotalCoin = FocusNode();

  /// Stop Limit
  final TextEditingController _controllerStopLimitStop =
  TextEditingController();
  final FocusNode _focusNodeStopLimitStop = FocusNode();
  final TextEditingController _controllerStopLimitLimit =
  TextEditingController();
  final FocusNode _focusNodeStopLimitLimit = FocusNode();
  final TextEditingController _controllerStopLimitQuantity =
  TextEditingController();
  final FocusNode _focusNodeStopLimitQuantity = FocusNode();

  /// Stop Market
  final TextEditingController _controllerStopMarketStop =
  TextEditingController();
  final FocusNode _focusNodeStopMarketStop = FocusNode();
  final TextEditingController _controllerStopMarketLimit =
  TextEditingController();
  final FocusNode _focusNodeStopMarketLimit = FocusNode();
  final TextEditingController _controllerStopMarketQuantity =
  TextEditingController();
  final FocusNode _focusNodeStopMarketQuantity = FocusNode();

  /// Trailing Stop
  final TextEditingController _controllerTrailingStopTD =
  TextEditingController();
  final FocusNode _focusNodeTrailingStopTD = FocusNode();
  final TextEditingController _controllerTrailingStopLimit =
  TextEditingController();
  final FocusNode _focusNodeTrailingStopLimit = FocusNode();
  final TextEditingController _controllerTrailingStopQuantity =
  TextEditingController();
  final FocusNode _focusNodeTrailingStopQuantity = FocusNode();

  /// Stop Market
  final TextEditingController _controllerOCCStopTP = TextEditingController();
  final FocusNode _focusNodeOCCStopTP = FocusNode();
  final TextEditingController _controllerOCCActiveSL = TextEditingController();
  final FocusNode _focusNodeOCCActiveSL = FocusNode();
  final TextEditingController _controllerOCCLimitQuantity =
  TextEditingController();
  final FocusNode _focusNodeOCCLimitQuantity = FocusNode();
  final TextEditingController _controllerOCCQuantity = TextEditingController();
  final FocusNode _focusNodeOCCQuantity = FocusNode();

  bool get _hasFocus => _focusNodeTotalCoin.hasFocus;
  bool get _hasText => _controllerTotalCoin.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        ref.read(websocketConnectionProvider.notifier).connect("btc/usdt");
        ref.read(websocketBidsAskProvider.notifier).connect("btc/usdt");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final marketData = ref.watch(marketDataProvider);
    final orderBook = ref.watch(orderBookProvider);
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _buildHeader(screenSize),
            _buildDropdown(screenSize, marketData),
            _buildBody(screenSize, orderBook, marketData)
          ],
        ),
      ),
    );
  }

  //header
  Widget _buildHeader(Size screenSize) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.03,
            vertical: screenSize.height * 0.01,
          ),
          child: Row(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildTab('USDS-M', index: 0, ref: ref),
                        _buildTab('COIN-M', index: 1, ref: ref),
                        _buildTab('Quyền chọn', index: 2, ref: ref),
                      ],
                    ),
                  )),
              const SizedBox(width: 5),
              const Icon(
                Icons.menu,
                size: 27,
                color: Colors.black,
              )
            ],
          ),
        ),
        Divider(color: Colors.grey[400], thickness: 0.5),
      ],
    );
  }

  //trades tabs
  Widget _buildTab(String text, {int index = 0, WidgetRef? ref}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GestureDetector(
          onTap: () =>
          {ref?.read(selectedIndexProvider.notifier).state = index},
          child: Text(
            text,
            style: TextStyle(
              fontSize: 17,
              color: ref?.watch(selectedIndexProvider) == index
                  ? Colors.black
                  : Colors.grey[500],
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  //drop down menu
  Widget _buildDropdown(Size screenSize, MarketDataModel model) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.03,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) {
                      return const CoinBottomSheet();
                    },
                  );
                },
                child: const Row(
                  children: [
                    Text(
                      'BTC/USDT',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                      size: 25,
                    ),
                  ],
                ),
              ),
              Text(
                "${model.priceChangePercent.toStringAsFixed(2)} %",
                style: TextStyle(
                  color: model.priceChangePercent < 0
                      ? ColorStyle.redColor
                      : ColorStyle.greenColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          const SizedBox(width: 12),
          Row(
            children: [
              Icon(
                Icons.compare_arrows,
                color: Colors.grey[400],
                size: 18,
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.more_horiz,
                color: Colors.grey[400],
                size: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
      Size screenSize, OrderBookData orderBook, MarketDataModel model) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.03,
        vertical: screenSize.height * 0.01,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildPriceQuantityHeader(screenSize, orderBook),
                      SizedBox(height: screenSize.height * 0.003),
                      _buildMainPrice(model),
                      _buildSubPrice(model),
                      _buildPriceQuantityBody(screenSize, orderBook),
                      SizedBox(height: screenSize.height * 0.005),
                      _buildBottomRow(),
                    ],
                  )),
              SizedBox(width: screenSize.width * 0.03),
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      _buildButtonBuySell(screenSize),
                      SizedBox(height: screenSize.height * 0.01),
                      _buildButtonLimit(screenSize),
                      ref.watch(selectedSpotTypeProvider) == 1
                          ? Column(
                        children: [
                          SizedBox(height: screenSize.height * 0.01),
                          _buildButtonPriceUSDT(screenSize, model),
                          SizedBox(height: screenSize.height * 0.01),
                          _buildButtonQuantityBTC(screenSize),
                          SizedBox(height: screenSize.height * 0.01),
                        ],
                      )
                          : const SizedBox(height: 0),
                      ref.watch(selectedSpotTypeProvider) == 2
                          ? Column(
                        children: [
                          SizedBox(height: screenSize.height * 0.01),
                          _buildButtonPriceMarket(screenSize),
                          SizedBox(height: screenSize.height * 0.01),
                          _buildButtonSelectedTypeCoin(screenSize),
                          SizedBox(height: screenSize.height * 0.004)
                        ],
                      )
                          : const SizedBox(height: 0),
                      ref.watch(selectedSpotTypeProvider) == 3
                          ? Column(
                        children: [
                          SizedBox(height: screenSize.height * 0.01),
                          _buildCommonButtonStopLimit(screenSize,
                              controller: _controllerStopLimitStop,
                              label: "Stop (USDT)",
                              focusNode: _focusNodeStopLimitStop),
                          SizedBox(height: screenSize.height * 0.01),
                          _buildCommonButtonStopLimit(screenSize,
                              controller: _controllerStopLimitLimit,
                              label: "Limit (USDT)",
                              focusNode: _focusNodeStopLimitLimit),
                          SizedBox(height: screenSize.height * 0.01),
                          _buildCommonButtonStopLimit(screenSize,
                              controller: _controllerStopLimitQuantity,
                              label: "Số lượng (USDT)",
                              focusNode: _focusNodeStopLimitQuantity),
                          SizedBox(height: screenSize.height * 0.01),
                        ],
                      )
                          : const SizedBox(height: 0),
                      ref.watch(selectedSpotTypeProvider) == 4
                          ? Column(
                        children: [
                          SizedBox(height: screenSize.height * 0.01),
                          _buildCommonButtonStopLimit(screenSize,
                              controller: _controllerStopMarketStop,
                              label: "Stop (USDT)",
                              focusNode: _focusNodeStopMarketStop),
                          SizedBox(height: screenSize.height * 0.01),
                          _buildButtonPriceMarket(screenSize),
                          SizedBox(height: screenSize.height * 0.01),
                          _buildCommonButtonStopLimit(screenSize,
                              controller: _controllerStopMarketLimit,
                              label: "Số lượng (USDT)",
                              focusNode: _focusNodeStopMarketLimit),
                          SizedBox(height: screenSize.height * 0.01),
                        ],
                      )
                          : const SizedBox(height: 0),
                      ref.watch(selectedSpotTypeProvider) == 5
                          ? Column(
                        children: [
                          SizedBox(height: screenSize.height * 0.01),
                          _buildButtonTrailingStopTD(screenSize),
                          SizedBox(height: screenSize.height * 0.01),
                          _buildCommonButtonStopLimit(screenSize,
                              controller: _controllerTrailingStopLimit,
                              label: "Limit (USDT)",
                              focusNode: _focusNodeTrailingStopLimit),
                          SizedBox(height: screenSize.height * 0.01),
                          _buildCommonButtonStopLimit(screenSize,
                              controller: _controllerTrailingStopQuantity,
                              label: "Số lượng (BTC)",
                              focusNode: _focusNodeTrailingStopQuantity),
                          SizedBox(height: screenSize.height * 0.01),
                        ],
                      )
                          : const SizedBox(height: 0),
                      ref.watch(selectedSpotTypeProvider) == 6
                          ? Column(
                        children: [
                          SizedBox(height: screenSize.height * 0.01),
                          _buildCommonButtonTextFieldWithLabel(screenSize,
                              controller: _controllerOCCStopTP,
                              label: "Chốt lời",
                              focusNode: _focusNodeOCCStopTP,
                              hinText: 'Giới hạn TP (USDT)'),
                          SizedBox(height: screenSize.height * 0.01),
                          _buildCommonButtonTextFieldWithLabel(screenSize,
                              controller: _controllerOCCActiveSL,
                              label: "Cắt lỗ",
                              focusNode: _focusNodeOCCActiveSL,
                              hinText: 'Kích hoạt SL (USDT)'),
                          SizedBox(height: screenSize.height * 0.01),
                          _buildButtonOCCLimitButton(screenSize),
                          SizedBox(height: screenSize.height * 0.01),
                          _buildCommonButtonStopLimit(screenSize,
                              controller: _controllerOCCQuantity,
                              label: "Số lượng (BTC)",
                              focusNode: _focusNodeOCCQuantity),
                          SizedBox(height: screenSize.height * 0.01),
                        ],
                      )
                          : const SizedBox(height: 0),
                      SizedBox(height: screenSize.height * 0.02),
                      _buildStepper(screenSize),
                      ref.watch(selectedSpotTypeProvider) == 6 || ref.watch(selectedSpotTypeProvider) == 1 || ref.watch(selectedSpotTypeProvider) == 3
                          ? Column(
                        children: [
                          SizedBox(height: screenSize.height * 0.016),
                          _buildButtonTotalUSDT(screenSize),
                          SizedBox(height: screenSize.height * 0.01),
                        ],
                      ) : const SizedBox(height: 8),
                      ref.watch(selectedSpotTypeProvider) == 1
                          ? Column(
                        children: [
                          SizedBox(height: screenSize.height * 0.008),
                          _buildTP_SL(screenSize),
                        ],
                      ) : const SizedBox(height: 0),
                      ref.watch(selectedSpotTypeProvider) == 3
                          ? Column(
                        children: [
                          SizedBox(height: screenSize.height * 0.005),
                          _buildIceberg(screenSize),
                          SizedBox(height: screenSize.height * 0.002),
                        ],
                      ) : const SizedBox(height: 0),
                      ref.watch(selectedSpotTypeProvider) == 5
                          ? Column(
                        children: [
                          SizedBox(height: screenSize.height * 0.01),
                          _buildPriceActive(screenSize),
                          SizedBox(height: screenSize.height * 0.01),
                        ],
                      ) : const SizedBox(height: 0),
                      _buildInfoButtonBuyOrSell(screenSize)
                    ],
                  ))
            ],
          ),
          SizedBox(height: screenSize.height * 0.01),
          _buildTradeTabs(screenSize)
        ],
      ),
    );
  }

  //Cột bên trái
  Widget _buildPriceQuantityHeader(Size screenSize, OrderBookData orderBook) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Giá', style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text('(USDT)',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
                SizedBox(height: 5)
              ],
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Số lượng',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text('(BTC)',
                    style: TextStyle(color: Colors.grey, fontSize: 12))
              ],
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * (DataOrigin.bidsHeightBySpotTypes[ref.watch(selectedSpotTypeProvider)] ?? 0),
          // height: MediaQuery.of(context).size.width * 0.445,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderBook.asks.take(DataOrigin.takeUpRecordByCoinType[ref.watch(selectedSpotTypeProvider)] ?? 0).length,
            itemBuilder: (context, index) {
              final ask = orderBook.asks.take(DataOrigin.takeUpRecordByCoinType[ref.watch(selectedSpotTypeProvider)] ?? 0).toList()[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 20,
                    alignment: Alignment.center,
                    child: Text(
                      numberFormat.format(ask.price ?? 0),
                      style: const TextStyle(
                        color: ColorStyle.redColor,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 20,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Text(
                        (ask.quantity ?? 0).toStringAsFixed(5),
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPriceQuantityBody(Size screenSize, OrderBookData orderBook) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * (DataOrigin.bidsHeightBySpotTypes[ref.watch(selectedSpotTypeProvider)] ?? 0),
      // height: MediaQuery.of(context).size.width * 0.445,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: orderBook.bids.take(DataOrigin.takeUpRecordByCoinType[ref.watch(selectedSpotTypeProvider)] ?? 0).length,
        itemBuilder: (context, index) {
          final model = orderBook.bids.take(DataOrigin.takeUpRecordByCoinType[ref.watch(selectedSpotTypeProvider)] ?? 0).toList()[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 20,
                alignment: Alignment.center,
                child: Text(
                  numberFormat.format(model.price ?? 0),
                  style: const TextStyle(
                    color: ColorStyle.greenColor,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                height: 20,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Text(
                    (model.quantity ?? 0).toStringAsFixed(5),
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMainPrice(MarketDataModel model) {
    return Text(
      '${model.price ?? "0"}',
      style: const TextStyle(
          color: Color(0xFF25C26E), fontSize: 17, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSubPrice(MarketDataModel model) {
    return Text(
      '≈ ${model.price ?? "0"} \$',
      style: TextStyle(color: Colors.grey[500], fontSize: 13),
    );
  }

  Widget _buildBottomRow() {
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) {
            return const BidFormPopup();
          },
        );
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 23,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${DataOrigin.bidFormPopupTypes[ref.watch(ProviderCommon.selectedBidFormPopupProvider)]}',
                        style: TextStyle(color: Colors.grey[500], fontSize: 13)),
                    Icon(Icons.arrow_drop_down,
                        color: Colors.grey[500], size: 20),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 7),
          _buildMiniBars(),
        ],
      ),
    );
  }

  Widget _buildMiniBars() {
    return SizedBox(
      height: 20,
      width: 20,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: List.generate(
                3,
                    (index) => Expanded(
                  child: Container(
                    color: Colors.grey,
                    margin:
                    index < 2 ? const EdgeInsets.only(bottom: 1.5) : null,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(flex: 1, child: Container(color: Colors.red)),
                const SizedBox(height: 2),
                Expanded(
                    flex: 1, child: Container(color: const Color(0xFF25C26E))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonBuySell(Size screenSize) {
    return Column(
      children: [
        Container(
          height: 27,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!, width: 0.4),
            borderRadius: BorderRadius.circular(7),
          ),
          clipBehavior: Clip.antiAlias, // Giúp nội dung bên trong cũng bo tròn
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ref.read(isBuySelectedProvider.notifier).state = true;
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                      ),
                    ),
                    child: ClipPath(
                      clipper: RightTriangleClipper(),
                      child: Container(
                        color: ref.watch(isBuySelectedProvider)
                            ? ColorStyle.greenColor
                            : Colors.transparent,
                        alignment: Alignment.center,
                        child: Text(
                          'Mua',
                          style: TextStyle(
                            color: ref.watch(isBuySelectedProvider)
                                ? Colors.white
                                : Colors.grey[500],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ref.read(isBuySelectedProvider.notifier).state = false;
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                    ),
                    child: ClipPath(
                      clipper: LeftTriangleClipper(),
                      child: Container(
                        color: !ref.watch(isBuySelectedProvider)
                            ? ColorStyle.redColor
                            : Colors.transparent,
                        alignment: Alignment.center,
                        child: Text(
                          'Bán',
                          style: TextStyle(
                            color: !ref.watch(isBuySelectedProvider)
                                ? Colors.white
                                : Colors.grey[500],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildButtonLimit(Size screenSize) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) {
            return const SpotTypePopupWidget();
          },
        );
      },
      child: Container(
        height: 30,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Color(0xfff5f5f5),
            borderRadius: BorderRadius.all(Radius.circular(7))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.info_sharp,
                size: 18,
                color: Colors.grey,
              ),
              Text(
                "${DataOrigin.spotTypes[ref.watch(selectedSpotTypeProvider)]}",
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.arrow_drop_down, size: 20, color: Colors.grey)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonSelectedTypeCoin(Size screenSize) {
    return Container(
      height: 37,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Color(0xfff5f5f5),
          borderRadius: BorderRadius.all(Radius.circular(7))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    top: (_hasFocus || _hasText) ? 2 : 11,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: (_hasFocus || _hasText) ? 12 : 14,
                        color: ColorStyle.grayColor,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      child: const Text("Số lượng"),
                    ),
                  ),
                  // TextField ẩn viền
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 5), // đẩy xuống dưới label
                    child: TextField(
                      controller: _controllerTotalCoin,
                      focusNode: _focusNodeTotalCoin,
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      cursorHeight: 15,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration.collapsed(
                        hintText: "",
                      ),
                      cursorColor: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (context) {
                        return const CoinTradingTypePopup();
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${DataOrigin.coinTradingTypes[ref.watch(selectedCoinTradingTypeProvider)]}",
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      const Icon(Icons.arrow_drop_down,
                          size: 20, color: Colors.grey)
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildCommonButtonStopLimit(Size screenSize,
      {required TextEditingController controller,
        required String label,
        required FocusNode focusNode}) {
    return Container(
      height: 37,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Color(0xfff5f5f5),
          borderRadius: BorderRadius.all(Radius.circular(7))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.remove, size: 20, color: Colors.grey),
                )),
            Expanded(
              flex: 5,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    top: (focusNode.hasFocus || controller.text.isNotEmpty)
                        ? 2
                        : 11,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize:
                        (focusNode.hasFocus || controller.text.isNotEmpty)
                            ? 12
                            : 13,
                        color: ColorStyle.grayColor,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      child: Text(label),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 5),
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      cursorHeight: 15,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration.collapsed(
                        hintText: "",
                      ),
                      cursorColor: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (context) {
                        return const CoinTradingTypePopup();
                      },
                    );
                  },
                  child: const Icon(Icons.add, size: 20, color: Colors.grey),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildCommonButtonTextFieldWithLabel(Size screenSize,
      {required TextEditingController controller,
        required String label,
        required FocusNode focusNode,
        required String hinText}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: ColorStyle.textDisableColor),),
            Container(
              height: 37,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.remove,
                                size: 20, color: Colors.grey),
                          )),
                      Expanded(
                        flex: 5,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 200),
                              top:
                              (focusNode.hasFocus || controller.text.isNotEmpty)
                                  ? 2
                                  : 11,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 200),
                                style: TextStyle(
                                  fontSize: (focusNode.hasFocus ||
                                      controller.text.isNotEmpty)
                                      ? 12
                                      : 13,
                                  color: ColorStyle.grayColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                                child: Text(hinText),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16, bottom: 5),
                              child: TextField(
                                controller: controller,
                                focusNode: focusNode,
                                keyboardType: const TextInputType.numberWithOptions(
                                    decimal: true),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                                cursorHeight: 15,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration.collapsed(
                                  hintText: "",
                                ),
                                cursorColor: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                ),
                                builder: (context) {
                                  return const CoinTradingTypePopup();
                                },
                              );
                            },
                            child:
                            const Icon(Icons.add, size: 20, color: Colors.grey),
                          ))
                    ],
                  )),
            )
          ],
        ));
  }

  Widget _buildButtonPriceUSDT(Size screenSize, MarketDataModel model) {
    return Container(
      height: 37,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Color(0xfff5f5f5),
          borderRadius: BorderRadius.all(Radius.circular(7))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.remove,
              size: 18,
              color: Colors.grey,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Giá (USDT)',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  model.price.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Icon(Icons.add, size: 20, color: Colors.grey)
          ],
        ),
      ),
    );
  }

  Widget _buildButtonQuantityBTC(Size screenSize) {
    return Container(
      height: 37,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Color(0xfff5f5f5),
          borderRadius: BorderRadius.all(Radius.circular(7))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.remove,
              size: 18,
              color: Colors.grey,
            ),
            Text(
              'Số lượng (BTC)',
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500),
            ),
            Icon(Icons.add, size: 20, color: Colors.grey)
          ],
        ),
      ),
    );
  }

  double dragPosition = 0.0;
  final double stepSize = 77.0;
  double get totalWidth => (totalSteps - 1) * stepSize;

  Widget _buildStepper(Size screenSize) {
    return SizedBox(
      height: 19,
      width: totalWidth,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            dragPosition += details.delta.dx;
            dragPosition = dragPosition.clamp(0, totalWidth / 2 + 57);
          });
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                children: List.generate(totalSteps * 2 - 1, (index) {
                  if (index % 2 == 0) {
                    int stepIndex = index ~/ 2;
                    bool isActive = stepIndex * stepSize/2 <= dragPosition;
                    return _buildDiamond(isActive: isActive);
                  } else {
                    int stepIndex = index ~/ 2;
                    bool isActive = stepIndex * stepSize/2 < dragPosition;
                    return Container(width: stepSize / 2 + 3, height: 1, color: isActive ? ColorStyle.blackColor : ColorStyle.grayColor);
                  }
                }),
              ),
            ),
            Positioned(
              left: dragPosition,
              top: 0,
              child: GestureDetector(
                child: Transform.rotate(
                  angle: 3.14 / 4,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                        color: ColorStyle.whiteColor,
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: const BorderRadius.all(Radius.circular(3))
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    //   Row(
    //   children: List.generate(totalSteps * 2 - 1, (index) {
    //     if (index.isOdd) {
    //       return Expanded(
    //         child: Container(
    //           height: 1,
    //           color: Colors.grey.shade300,
    //         ),
    //       );
    //     } else {
    //       int stepIndex = index ~/ 2;
    //       bool isActive = stepIndex == currentStep;
    //       return CustomPaint(
    //         size: const Size(15, 15),
    //         painter: DiamondPainter(isActive: isActive),
    //       );
    //     }
    //   }),
    // );
  }

  Widget _buildDiamond({required bool isActive}) {
    return Transform.rotate(
      angle: 3.14 / 4,
      child: Container(
        width: 9,
        height: 9,
        margin: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
            color:  isActive ? ColorStyle.blackColor : null,
            border: Border.all(
              color: isActive ? ColorStyle.blackColor : ColorStyle.grayColor,
              width: 0.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(2))
        ),
      ),
    );
  }
  Widget _buildButtonPriceMarket(Size screenSize) {
    return Container(
      height: 37,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Color(0xfff5f5f5),
          borderRadius: BorderRadius.all(Radius.circular(7))),
      child: const Center(
        child: Text(
          "Giá thị trường",
          style: TextStyle(
              fontSize: 15,
              color: ColorStyle.grayColor,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildButtonTrailingStopTD(Size screenSize) {
    return SizedBox(
      height: 37,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              height: 37,
              decoration: const BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              child: Center(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      top: (_focusNodeTrailingStopTD.hasFocus ||
                          _controllerTrailingStopTD.text.isNotEmpty)
                          ? 2
                          : 11,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: (_focusNodeTrailingStopTD.hasFocus ||
                              _controllerTrailingStopTD.text.isNotEmpty)
                              ? 12
                              : 15,
                          color: ColorStyle.grayColor,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        child: const Text("T/D(%)"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 5),
                      child: TextField(
                        controller: _controllerTrailingStopTD,
                        focusNode: _focusNodeTrailingStopTD,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        cursorHeight: 15,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration.collapsed(
                          hintText: "",
                        ),
                        cursorColor: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                _controllerTrailingStopTD.text = "1";
              },
              child: Container(
                height: 37,
                decoration: const BoxDecoration(
                    color: Color(0xfff5f5f5),
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                child: const Center(
                  child: Text(
                    "1%",
                    style: TextStyle(
                        fontSize: 13,
                        color: ColorStyle.blackColor,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                _controllerTrailingStopTD.text = "2";
              },
              child: Container(
                height: 37,
                decoration: const BoxDecoration(
                    color: Color(0xfff5f5f5),
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                child: const Center(
                  child: Text(
                    "2%",
                    style: TextStyle(
                        fontSize: 13,
                        color: ColorStyle.blackColor,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtonOCCLimitButton(Size screenSize) {
    return SizedBox(
      height: 37,
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  _buildCommonButtonStopLimit(screenSize,
                      controller: _controllerOCCLimitQuantity,
                      label: "${DataOrigin.ocoLimitOrMarketLabelTypes[ref.watch(ProviderCommon.selectedLimitOrMarketOCOProvider)]}",
                      focusNode: _focusNodeOCCLimitQuantity),
                ],
              )
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) {
                    return const OceLimitOrMarketPopup();
                  },
                );
              },
              child: Container(
                height: 37,
                padding: const EdgeInsets.only(left: 2, right: 5),
                decoration: const BoxDecoration(
                    color: Color(0xfff5f5f5),
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                child:  Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "${DataOrigin.ocoLimitOrMarketTypes[ref.watch(ProviderCommon.selectedLimitOrMarketOCOProvider)]}",
                        style: const TextStyle(
                            fontSize: 13,
                            color: ColorStyle.blackColor,
                            fontWeight: FontWeight.normal),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const Expanded(
                        flex: 1,
                        child: Icon(Icons.arrow_drop_down,  color: ColorStyle.grayColor, size: 20))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildButtonTotalUSDT(Size screenSize) {
    return Container(
      height: 37,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Color(0xfff5f5f5),
          borderRadius: BorderRadius.all(Radius.circular(7))),
      child: const Center(
        child: Text(
          'Tổng (USDT)',
          style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildInfoButtonBuyOrSell(Size screenSize){
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 2),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Khả dụng',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              Row(
                children: [
                  Text(
                    '0 USDT',
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(
                    Icons.add_circle,
                    color: Colors.orange,
                    size: 19,
                  )
                ],
              )
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mua tối đa',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              Text(
                '0,00000 BTC',
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Phí dự kiến',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              Text(
                '-- BTC',
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 37,
            width: double.infinity,
            decoration: BoxDecoration(
                color: ref.watch(isBuySelectedProvider)
                    ? ColorStyle.greenColor
                    : ColorStyle.redColor,
                borderRadius: const BorderRadius.all(Radius.circular(7))),
            child: Center(
              child: Text(
                ref.watch(isBuySelectedProvider) ? 'Mua BTC' : 'Bán BTC',
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIceberg(Size screenSize) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 13,
                width: 13,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(3))),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                'Tảng băng',
                style: TextStyle(color: Colors.black, fontSize: 13),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceActive(Size screenSize) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 13,
                width: 13,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(3))),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                'Giá kích hoạt',
                style: TextStyle(color: Colors.black, fontSize: 13),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTP_SL(Size screenSize) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 13,
                width: 13,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(3))),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                'TP/SL',
                style: TextStyle(color: Colors.black, fontSize: 13),
              )
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Container(
                height: 13,
                width: 13,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(3))),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                'Tảng băng',
                style: TextStyle(color: Colors.black, fontSize: 13),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> showModelBottomSheet() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return const CoinBottomSheet();
      },
    );
  }

  Widget _buildTradeTabs(Size screenSize) {
    return Container(
      padding: EdgeInsets.only(top: screenSize.height * 0.015),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: screenSize.width * 0.02),
            _buildTabText('Vị thế (0)', index: 0, ref: ref),
            _buildTabText('Lệnh chờ(2)', index: 1, ref: ref),
            _buildTabText('Lưới Hợp đồng tương lai', index: 2, ref: ref),
          ],
        ),
      ),
    );
  }

  Widget _buildTabText(String text,
      {bool isSelected = false, int index = 0, WidgetRef? ref}) {
    final isSelected = ref?.watch(selectedTabIndexProvider) == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () =>
        {ref?.read(selectedTabIndexProvider.notifier).state = index},
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: ref?.watch(selectedTabIndexProvider) == index
                    ? Colors.black
                    : Colors.grey[500],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 2,
              width: 24,
              color: ref?.watch(selectedTabIndexProvider) == index
                  ? const Color(0xFFFFC107)
                  : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

//cắt góc hình tam giác
class RightTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // top-left
    path.lineTo(size.width - 15, 0); // top-right inward
    path.lineTo(size.width, size.height / 2); // right-center (triangle tip)
    path.lineTo(size.width - 15, size.height); // bottom-right inward
    path.lineTo(0, size.height); // bottom-left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LeftTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(15, 0); // top-left inward
    path.lineTo(size.width, 0); // top-right
    path.lineTo(size.width, size.height); // bottom-right
    path.lineTo(15, size.height); // bottom-left inward
    path.lineTo(0, size.height / 2); // left-center (triangle tip)
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//class stepper
class DiamondPainter extends CustomPainter {
  final bool isActive;

  DiamondPainter({required this.isActive});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isActive ? Colors.black : Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = isActive ? 1.5 : 1;

    final path = Path();
    path.moveTo(size.width / 2, 0); // top
    path.lineTo(size.width, size.height / 2); // right
    path.lineTo(size.width / 2, size.height); // bottom
    path.lineTo(0, size.height / 2); // left
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
