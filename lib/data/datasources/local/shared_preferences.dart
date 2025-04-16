import 'package:binance_mobile/data/datasources/local/shared_preferences_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocal{

  static Future<String?> getLanguageCode() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferenceConfig.LANGUAGE_CODE);
  }

  static Future<void> setLanguageCode(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferenceConfig.LANGUAGE_CODE, value);
  }

  static Future<void> removeLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferenceConfig.LANGUAGE_CODE);
  }
}