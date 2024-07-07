import 'package:flutter/foundation.dart';
import 'package:samyati/Theme/theme_shared_preference.dart';

class ThemeModal extends ChangeNotifier {
  late bool _isDark;
  late ThemeSharedPreference themeSharedPreference;
  bool get isDark => _isDark;

  ThemeModal() {
    _isDark = false;
    themeSharedPreference = ThemeSharedPreference();
    getThemePreference();
  }

  set isDark(bool value) {
    _isDark = value;
    themeSharedPreference.setTheme(value);
    notifyListeners();
  }

  getThemePreference() async {
    _isDark = await themeSharedPreference.getTheme();
    notifyListeners();
  }
}
