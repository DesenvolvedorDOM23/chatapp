import 'package:chatapp/theme/dark_mode.dart';
import 'package:chatapp/theme/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == DarkMode;

  set themeData(ThemeData themeData) {
    _themeData = DarkMode;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = isDarkMode ? lightMode : DarkMode;
    notifyListeners();
  }
}
