import 'package:binance_mobile/presentations/widgets/button/category_button.dart';
import 'package:binance_mobile/presentations/widgets/footer/custom_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: AppBar(
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  'assets/images/binance.png',
                  height: 30,
                  fit: BoxFit.contain,
                ),
              ),
              title: TextField(
                decoration: InputDecoration(
                  hintText: 'REZ',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              actions: const [
                Icon(Icons.notifications, color: Colors.black),
                SizedBox(width: 10),
                Icon(Icons.headset_mic, color: Colors.black),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),

        //body
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appLocalizations.totalEstimatedValue,
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('0.00đ',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700],
                        ),
                        child: Text(
                          appLocalizations.depositMoney,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CategoryButtonImage(
                  imagePath: 'assets/images/p2p.png',
                  label: 'P2P',
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const P2PTradingScreen()),
                    // );
                  },
                ),
                CategoryButtonImage(
                  imagePath: 'assets/images/earnings.png',
                  label: 'Earn',
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const EarnScreen()),
                    // );
                  },
                ),
                CategoryButtonImage(
                  imagePath: 'assets/images/exchange.png',
                  label: 'Refer2Earn',
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const Refer2EarnScreen()),
                    // );
                  },
                ),
                CategoryButtonImage(
                  imagePath: 'assets/images/problem.png',
                  label: appLocalizations.frequentlyAskedQuestions,
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const HelpSupportScreen()),
                    // );
                  },
                ),
                CategoryButtonImage(
                  imagePath: 'assets/images/other.png',
                  label: appLocalizations.more,
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const HelpSupportScreen()),
                    // );
                  },
                ),
              ],
            ),
            //Divider
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                color: Colors.grey[400],
                thickness: 0.5,
              ),
            ),
            //Danh sách yêu thích
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CategoryButton(
                      label: appLocalizations.favoritesList,
                      index: 0,
                      isSelected: selectedIndex == 0,
                      onPressed: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                    ),
                    CategoryButton(
                      label: appLocalizations.popular,
                      index: 1,
                      isSelected: selectedIndex == 1,
                      onPressed: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                    ),
                    CategoryButton(
                      label: appLocalizations.priceIncrease,
                      index: 2,
                      isSelected: selectedIndex == 2,
                      onPressed: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                    ),
                    CategoryButton(
                      label: appLocalizations.discount,
                      index: 3,
                      isSelected: selectedIndex == 3,
                      onPressed: () {
                        setState(() {
                          selectedIndex = 3;
                        });
                      },
                    ),
                    CategoryButton(
                      label: appLocalizations.news,
                      index: 4,
                      isSelected: selectedIndex == 4,
                      onPressed: () {
                        setState(() {
                          selectedIndex = 4;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            //Table biến động thị trường
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        appLocalizations.name,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        appLocalizations.latestPrice,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        appLocalizations.volatility,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(
            //   child: ListView(
            //     children: const [
            //       CryptoItem(
            //         name: 'BNB',
            //         price: '602.74',
            //         change: '+0.43%',
            //         value: 'đ15,409,662.89',
            //       ),
            //     ],
            //   ),
            // ),

            // const CryptoList()
          ],
        ),
        bottomNavigationBar: const CustomFooter(currentIndex: 0),
      ),
    );
  }
}
