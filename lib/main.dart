import 'package:binance_mobile/data/datasources/local/shared_preferences.dart';
import 'package:binance_mobile/presentations/screens/login_page/login_page.dart';
import 'package:binance_mobile/presentations/screens/main_page/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/languages/l10n_language_config.dart';
import 'package:flutter/services.dart';

import 'presentations/screens/home_page/home_page.dart';
import 'package:binance_mobile/core/dependency_injection/injection_container.dart'
    as di;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static SharedPreferences? localStorage;

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    var prefs = await SharedPreferences.getInstance();
    SharedPreferencesLocal.setLanguageCode(newLocale.languageCode);
    state?.setLocale(newLocale);
  }

  Future<Locale> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();

    String languageCode = prefs.getString('languageCode') ?? 'en';
    String countryCode = prefs.getString('countryCode') ?? '';

    return Locale(languageCode, countryCode);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

Future<Locale> fetchLocale() async {
  var prefs = await SharedPreferences.getInstance();

  String languageCode = prefs.getString('languageCode') ?? 'en';
  String countryCode = prefs.getString('countryCode') ?? '';

  return Locale(languageCode, countryCode);
}

class _MyAppState extends State<MyApp> {
  // ignore: unused_field
  Locale _locale = const Locale(L10nLanguageConfig.defaultLanguage, '');
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: navigatorKey,
      locale: _locale,
      theme: ThemeData(fontFamily: 'IBMPFonts',  scaffoldBackgroundColor: Colors.white, ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi'),
        Locale('en'),
      ],
      home: const MainPage(),
    );
  }
}
