import 'package:clk/src/theme.dart';
import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme =
      ThemeData(useMaterial3: true, colorScheme: lightColorScheme);

  void toggleTheme() {
    currentTheme = (currentTheme.colorScheme == lightColorScheme)
        ? ThemeData(useMaterial3: true, colorScheme: darkColorScheme)
        : ThemeData(useMaterial3: true, colorScheme: lightColorScheme);
    notifyListeners();
  }
}
