import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvLoad{
  // ignore: non_constant_identifier_names
  static String BASE_URL = dotenv.get("BASE_URL");
  static String BASE_WEB_SOCKET = dotenv.get("BASE_WEB_SOCKET");
}