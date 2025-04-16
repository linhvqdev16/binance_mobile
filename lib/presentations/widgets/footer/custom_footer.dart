import 'package:binance_mobile/presentations/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomFooter extends StatefulWidget {
  final int currentIndex;

  const CustomFooter({super.key, required this.currentIndex});

  @override
  State<CustomFooter> createState() => _CustomFooterState();
}

class _CustomFooterState extends State<CustomFooter> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const DanhSachYeuThich()),
      // );
    } else if (index == 2) {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const MyBarChart()),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.home), label: appLocalizations.homePage),
        BottomNavigationBarItem(
            icon: const Icon(Icons.show_chart), label: appLocalizations.market),
        BottomNavigationBarItem(
            icon: const Icon(Icons.swap_horiz),
            label: appLocalizations.transaction),
        BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.chartLine),
            label: appLocalizations.futures),
        BottomNavigationBarItem(
            icon: const Icon(Icons.account_balance_wallet),
            label: appLocalizations.asset),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      iconSize: 26,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
      ),
      onTap: _onItemTapped,
    );
  }
}
