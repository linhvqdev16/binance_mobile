import 'package:flutter/material.dart';

class ThemStyle{
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.amber,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.amber,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
    ),
  );
}