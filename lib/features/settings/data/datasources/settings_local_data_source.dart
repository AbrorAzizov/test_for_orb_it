import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  Future<void> cacheThemeMode(ThemeMode themeMode);
  ThemeMode getThemeMode();
  Future<void> cacheLocale(Locale locale);
  Locale getLocale();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const _themeKey = 'theme_mode';
  static const _localeKey = 'locale';

  SettingsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheThemeMode(ThemeMode themeMode) async {
    await sharedPreferences.setString(_themeKey, themeMode.name);
  }

  @override
  ThemeMode getThemeMode() {
    final themeName = sharedPreferences.getString(_themeKey);
    return ThemeMode.values.firstWhere(
      (e) => e.name == themeName,
      orElse: () => ThemeMode.system,
    );
  }

  @override
  Future<void> cacheLocale(Locale locale) async {
    await sharedPreferences.setString(_localeKey, locale.languageCode);
  }

  @override
  Locale getLocale() {
    final languageCode = sharedPreferences.getString(_localeKey);
    if (languageCode == null) return const Locale('en');
    return Locale(languageCode);
  }
}
