import 'package:binance_mobile/core/languages/l10n_language_config.dart';
import 'package:binance_mobile/data/datasources/local/shared_preferences.dart';
import 'package:binance_mobile/main.dart';
import 'package:flutter/material.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  Locale _currentLocale = const Locale(L10nLanguageConfig.defaultLanguage);

  Future<void> onTap(String languageCode) async {
    setState(() {
      _currentLocale = Locale(languageCode);
    });
    MyApp.setLocale(context, _currentLocale);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? langCode = await SharedPreferencesLocal.getLanguageCode();
      setState(() {
        _currentLocale = Locale(langCode!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isVietnamese = _currentLocale.languageCode == "vi";

    return GestureDetector(
      onTap: () => onTap(isVietnamese ? "en" : "vi"),
      child: Container(
        height: 40,
        width: 110,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.all(3),
              alignment:
                  isVietnamese ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                height: 34,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "VI",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isVietnamese ? Colors.white : Colors.white70,
                    ),
                  ),
                  Text(
                    "EN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: !isVietnamese ? Colors.white : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
