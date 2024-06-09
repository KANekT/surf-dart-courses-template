import 'package:surf_flutter_courses_template/uikit/colors/color_scheme.dart';
import 'package:flutter/material.dart';

abstract class AppThemeData {
  static final lightTheme = ThemeData(
    extensions: [_lightOneColorScheme],
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: _lightOneColorScheme.primary,
      onPrimary: _lightOneColorScheme.onPrimary,
      secondary: _lightOneColorScheme.secondary,
      onSecondary: _lightOneColorScheme.onSecondary,
      error: _lightOneColorScheme.danger,
      onError: _lightOneColorScheme.onDanger,
      background: _lightOneColorScheme.background,
      onBackground: _lightOneColorScheme.onBackground,
      surface: _lightOneColorScheme.surface,
      onSurface: _lightOneColorScheme.onSurface,
    ),
    scaffoldBackgroundColor: _lightOneColorScheme.background,
    appBarTheme: AppBarTheme(
      color: _lightOneColorScheme.onPrimary,
      titleTextStyle: TextStyle(
        color: _lightOneColorScheme.textField
      ),
      iconTheme: IconThemeData(
        color: _lightOneColorScheme.primary,
      ),
      actionsIconTheme: IconThemeData(
        color: _lightOneColorScheme.primary
      )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _lightOneColorScheme.background,
      selectedItemColor: _lightOneColorScheme.primary,
      unselectedItemColor: _lightOneColorScheme.onBackground,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: _lightOneColorScheme.primary,
      contentTextStyle: TextStyle(
        color: _lightOneColorScheme.onPrimary,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    extensions: [_darkColorScheme],
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: _darkColorScheme.primary,
      onPrimary: _darkColorScheme.onPrimary,
      secondary: _darkColorScheme.secondary,
      onSecondary: _darkColorScheme.onSecondary,
      error: _darkColorScheme.danger,
      onError: _darkColorScheme.onDanger,
      background: _darkColorScheme.background,
      onBackground: _darkColorScheme.onBackground,
      surface: _darkColorScheme.surface,
      onSurface: _darkColorScheme.onSurface,
    ),
    scaffoldBackgroundColor: _darkColorScheme.background,
    appBarTheme: AppBarTheme(
      color: _darkColorScheme.primary,
      iconTheme: IconThemeData(
        color: _darkColorScheme.onPrimary,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _darkColorScheme.background,
      selectedItemColor: _darkColorScheme.primary,
      unselectedItemColor: _darkColorScheme.onBackground,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: _darkColorScheme.primary,
      contentTextStyle: TextStyle(
        color: _darkColorScheme.onPrimary,
      ),
    ),
  );

  static final _lightOneColorScheme = AppColorScheme.lightOne();
  static final _darkColorScheme = AppColorScheme.dark();
}
