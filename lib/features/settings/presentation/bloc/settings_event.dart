import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class ThemeChanged extends SettingsEvent {
  final ThemeMode themeMode;
  const ThemeChanged(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

class LanguageChanged extends SettingsEvent {
  final Locale locale;
  const LanguageChanged(this.locale);

  @override
  List<Object?> get props => [locale];
}
