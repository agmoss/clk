// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'theme.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData get currentTheme => _currentTheme;
  Color get gmtHandColor => _currentTheme.colorScheme.getGmtHandColor;
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

  void setGmtHandColor(Color color) {
    setColor(color,
        lightPrefKey: 'lightSecondary',
        copyWithColor: (scheme, color) => scheme.setGmtHandColor(color));
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
    final int primaryColor =
        prefs.getInt('${themePrefix}Primary') ?? colorScheme.primary.value;
    final int secondaryColor =
        prefs.getInt('${themePrefix}Secondary') ?? colorScheme.secondary.value;
    final int tertiaryColor =
        prefs.getInt('${themePrefix}Tertiary') ?? colorScheme.tertiary.value;
    final int outlineColor =
        prefs.getInt('${themePrefix}Outline') ?? colorScheme.outline.value;

    return colorScheme.copyWith(
        primary: Color(primaryColor),
        secondary: Color(secondaryColor),
        tertiary: Color(tertiaryColor),
        outline: Color(outlineColor));
  }

  Future<void> _saveColorToPrefs(String key, Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, color.value);
  }
}
