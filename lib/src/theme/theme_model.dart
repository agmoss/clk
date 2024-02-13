import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData get currentTheme => _currentTheme;

  Color get hourHandColor => _currentTheme.colorScheme.getHourHandColor;
  Color get minuteHandColor => _currentTheme.colorScheme.getMinuteHandColor;
  Color get secondHandColor => _currentTheme.colorScheme.getSecondHandColor;
  Color get lumeColor => _currentTheme.colorScheme.getLumeColor;

  late ThemeData _currentTheme;
  ColorScheme _lightColorScheme;
  ColorScheme _darkColorScheme;
  bool _isDarkMode;

  bool get isDarkMode => _isDarkMode;

  ThemeModel()
      : _lightColorScheme = lightColorScheme,
        _darkColorScheme = darkColorScheme,
        _isDarkMode = false {
    _loadPreferences();
  }

  void _updateCurrentTheme() {
    _currentTheme = ThemeData(
      useMaterial3: true,
      colorScheme: _isDarkMode ? _darkColorScheme : _lightColorScheme,
    );
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _updateCurrentTheme();
  }

  void setColor(Color color,
      {required String lightPrefKey,
      required ColorScheme Function(ColorScheme, Color) copyWithColor}) {
    _lightColorScheme = copyWithColor(_lightColorScheme, color);
    _saveColorToPrefs(lightPrefKey, color);

    _updateCurrentTheme();
  }

  void setLumeColor(Color color,
      {required ColorScheme Function(ColorScheme, Color) copyWithColor}) {
    if (_isDarkMode) {
      _darkColorScheme = copyWithColor(_darkColorScheme, color);
      _saveColorToPrefs('darkPrimary', color);
      _saveColorToPrefs('darkSecondary', color);
      _saveColorToPrefs('darkTertiary', color);
      _saveColorToPrefs('darkOutline', color);
      _updateCurrentTheme();
    }
  }

  void setHourHandColor(Color color) {
    setColor(color,
        lightPrefKey: 'lightPrimary',
        copyWithColor: (scheme, color) => scheme.setHourHandColor(color));
  }

  void setMinuteHandColor(Color color) {
    setColor(color,
        lightPrefKey: 'lightSecondary',
        copyWithColor: (scheme, color) => scheme.setMinuteHandColor(color));
  }

  void setSecondHandColor(Color color) {
    setColor(color,
        lightPrefKey: 'lightTertiary',
        copyWithColor: (scheme, color) => scheme.setSecondHandColor(color));
  }

  void setLume(Color color) {
    setLumeColor(color,
        copyWithColor: (scheme, color) => scheme.setLume(color));
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    _lightColorScheme = _updateColorSchemeFromPrefs(
      prefs: prefs,
      colorScheme: _lightColorScheme,
      themePrefix: 'light',
    );

    _darkColorScheme = _updateColorSchemeFromPrefs(
      prefs: prefs,
      colorScheme: _darkColorScheme,
      themePrefix: 'dark',
    );

    _updateCurrentTheme();
  }

  ColorScheme _updateColorSchemeFromPrefs({
    required SharedPreferences prefs,
    required ColorScheme colorScheme,
    required String themePrefix,
  }) {
    int primaryColor =
        prefs.getInt('${themePrefix}Primary') ?? colorScheme.primary.value;
    int secondaryColor =
        prefs.getInt('${themePrefix}Secondary') ?? colorScheme.secondary.value;
    int tertiaryColor =
        prefs.getInt('${themePrefix}Tertiary') ?? colorScheme.tertiary.value;
    int outlineColor =
        prefs.getInt('${themePrefix}Outline') ?? colorScheme.outline.value;

    return colorScheme.copyWith(
        primary: Color(primaryColor),
        secondary: Color(secondaryColor),
        tertiary: Color(tertiaryColor),
        outline: Color(outlineColor));
  }

  void _saveColorToPrefs(String key, Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, color.value);
  }
}
