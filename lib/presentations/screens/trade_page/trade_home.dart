import 'package:binance_mobile/core/styles/colors.dart';
import 'package:binance_mobile/presentations/widgets/popup/coin_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TradeHome extends ConsumerStatefulWidget {
  const TradeHome({super.key});

  @override
  ConsumerState<TradeHome> createState() => _TradeHomeState();
}

class _TradeHomeState extends ConsumerState<TradeHome>
    with SingleTickerProviderStateMixin {
  final selectedIndexProvider = StateProvider<int>((ref) => 0);
  final selectedTabIndexProvider = StateProvider<int>((ref) => 0);
  final isBuySelectedProvider = StateProvider<bool>((ref) => true);
  bool isBuySelected = true;
  late final int currentStep = 0;
  late final int totalSteps = 5;
  List<String> danhSachGia = [
    '92.745.69',
    '92.745.67',
    '92.744.69',
    '92.744.64',
    '92.744.46',
    '92.743.74',
    '92.742.86',
  ];
  List<String> danhSachSoLuong = [
    '0,00006',
    '0,00096',
    '0,00006',
    '0,00006',
    '0,00013',
    '0,00012',
    '0,06057',
  ];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _buildHeader(screenSize),
            _buildDropdown(screenSize),
            _buildBody(screenSize)
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
                    _buildTab('Chuyển đổi', index: 0, ref: ref),
                    _buildTab('Giao ngay', index: 1, ref: ref),
                    _buildTab('Margin', index: 2, ref: ref),
                    _buildTab('Mua/Bán', index: 3, ref: ref)
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
  Widget _buildDropdown(Size screenSize) {
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
                onTap: (){
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
              const Text(
                '-0.36%',
                style: TextStyle(
                  color: Colors.red,
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

  //body: Giá + Số lượng
  Widget _buildBody(Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.03,
        vertical: screenSize.height * 0.01,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      _buildPriceQuantityHeader(screenSize),
                      SizedBox(height: screenSize.height * 0.005),
                      _buildMainPrice(),
                      _buildSubPrice(),
                      _buildPriceQuantityBody(screenSize),
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
                      SizedBox(height: screenSize.height * 0.01),
                      _buildButtonPriceUSDT(screenSize),
                      SizedBox(height: screenSize.height * 0.01),
                      _buildButtonQuantityBTC(screenSize),
                      SizedBox(height: screenSize.height * 0.01),
                      _buildStepper(screenSize),
                      SizedBox(height: screenSize.height * 0.02),
                      _buildButtonTotalUSDT(screenSize),
                      SizedBox(height: screenSize.height * 0.01),
                      _buildTP_SL(screenSize),
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
  Widget _buildPriceQuantityHeader(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Giá',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            const Text('(USDT)',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 5),
            ...danhSachGia.map((price) => Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: screenSize.height * 0.001),
                  child: Text(price,
                      style: const TextStyle(fontSize: 13, color: Colors.red)),
                ))
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('Số lượng',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            const Text('(BTC)',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            ...danhSachSoLuong.map((sl) => Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: screenSize.height * 0.001),
                  child: Text(sl,
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black)),
                ))
          ],
        ),
      ],
    );
  }

  Widget _buildPriceQuantityBody(Size screenSize) {
    return Container(
      color: const Color(0xfff5fafa),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: danhSachGia
                .map((price) => Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.001),
                      child: Text(price,
                          style: const TextStyle(
                              fontSize: 13, color: Color(0xFF25C26E))),
                    ))
                .toList(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: danhSachSoLuong
                .map((sl) => Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.001),
                      child: Text(sl,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black)),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainPrice() {
    return const Text(
      '92.742,86',
      style: TextStyle(
          color: Color(0xFF25C26E), fontSize: 17, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSubPrice() {
    return Text(
      '≈ 92.742,86 \$',
      style: TextStyle(color: Colors.grey[500], fontSize: 13),
    );
  }

  Widget _buildBottomRow() {
    return Row(
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
                  Text('0.01',
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

//Cột bên phải
  Widget _buildButtonBuySell(Size screenSize) {
    return Column(
      children: [
        Container(
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!, width: 0.4),
            borderRadius: BorderRadius.circular(7),
          ),
          clipBehavior: Clip.antiAlias, // Giúp nội dung bên trong cũng bo tròn
          child: Row(
            children: [
              // Nút Mua
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

              // Nút Bán
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
    return Container(
      height: 27,
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
              Icons.info_sharp,
              size: 18,
              color: Colors.grey,
            ),
            Text(
              'Limit',
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold),
            ),
            Icon(Icons.arrow_drop_down, size: 20, color: Colors.grey)
          ],
        ),
      ),
    );
  }

  Widget _buildButtonPriceUSDT(Size screenSize) {
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Giá (USDT)',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '103685.81',
                  style: TextStyle(
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

  Widget _buildStepper(Size screenSize) {
    return Row(
      children: List.generate(totalSteps * 2 - 1, (index) {
        if (index.isOdd) {
          // Vẽ đường kẻ giữa các bước
          return Expanded(
            child: Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
          );
        } else {
          int stepIndex = index ~/ 2;
          bool isActive = stepIndex == currentStep;
          return CustomPaint(
            size: const Size(15, 15),
            painter: DiamondPainter(isActive: isActive),
          );
        }
      }),
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

  Widget _buildTP_SL(Size screenSize) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 15,
                width: 15,
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
                style: TextStyle(color: Colors.black, fontSize: 14),
              )
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Container(
                height: 15,
                width: 15,
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
                style: TextStyle(color: Colors.black, fontSize: 14),
              )
            ],
          ),
          const SizedBox(height: 10),
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
            decoration:  BoxDecoration(
                color: ref.watch(isBuySelectedProvider) ? ColorStyle.greenColor : ColorStyle.redColor,
                borderRadius: const BorderRadius.all(Radius.circular(7))),
            child:  Center(
              child: Text(
                 ref.watch(isBuySelectedProvider) ?  'Mua BTC' : 'Bán BTC',
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
            _buildTabText('Lệnh chờ (0)', index: 0, ref: ref),
            _buildTabText('Tài sản(2)', index: 1, ref: ref),
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
