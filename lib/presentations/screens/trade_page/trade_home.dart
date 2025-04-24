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
  final isBuySelectedProvider = StateProvider<bool>((ref) => true);
  bool isBuySelected = true;
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
              Text(
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

          // Price change percentage

          const SizedBox(width: 12),

          // Action buttons
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
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Column(
                children: [
                  _buildPriceQuantityHeader(screenSize),
                  const SizedBox(height: 5),
                  _buildMainPrice(),
                  _buildSubPrice(),
                  _buildPriceQuantityBody(screenSize),
                  const SizedBox(height: 5),
                  _buildBottomRow(),
                ],
              )),
          SizedBox(width: screenSize.width * 0.03),
          Expanded(
              flex: 4,
              child: Column(
                children: [_buildButtonBuySell(screenSize)],
              ))
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
            border: Border.all(color: Colors.grey[400]!, width: 0.7),
            borderRadius: BorderRadius.circular(7), // Bo tròn toàn bộ viền
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
                            ? const Color(0xFF25C26E)
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
                            ? const Color(0xFF25C26E)
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
