import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider() {
    getThemeData();
  }
  final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    // colorScheme: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
  );

  ThemeData? _themeData;
  ThemeData? get themeData => _themeData;
  set themeData(value) {
    _themeData = value;
    notifyListeners();
  }

  void setLightTheme() {
    themeData = lightTheme;
  }

  void setDarkTheme() {
    themeData = darkTheme;
  }

  void getThemeData() {
    SharedPreferences.getInstance().then((value) {
      if (value.getString('theme') == null ||
          value.getString('theme') == 'light') {
        themeData = lightTheme;
      } else {
        themeData = darkTheme;
      }
    });
  }
}
