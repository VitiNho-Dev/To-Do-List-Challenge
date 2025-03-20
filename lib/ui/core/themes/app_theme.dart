import 'package:flutter/material.dart';

import 'colors.dart';

abstract final class AppTheme {
  static TextTheme _textTheme(AppColors colors) {
    return TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: colors.textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: colors.accent,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: colors.accent,
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: colors.white,
      ),
    );
  }

  static ThemeData _createTheme(Brightness brightness, AppColors colors) {
    return ThemeData(
      brightness: brightness,
      textTheme: _textTheme(colors),
      extensions: [colors],
      scaffoldBackgroundColor: colors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 4,
      ),
      iconTheme: IconThemeData(color: colors.white),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        filled: true,
        fillColor: colors.secondary,
        hintStyle: TextStyle(color: colors.textColor, fontSize: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  static final darkTheme = _createTheme(
    Brightness.dark,
    AppColors(
      background: Color(0xFF31315C),
      primary: Color(0xFF3E79AE),
      secondary: Color(0xFF272951),
      accent: Color(0xFF9595C0),
      white: Color(0xFFFFFFFF),
      textColor: Color(0xFFFFFFFF),
      cardCompleted: Color(0xFF373760),
      cardNotCompleted: Color(0xFF43446A),
      borderIcon: Color(0xFFFFFFFF),
      lightGreen: Color(0xFFD4F8D3),
      success: Color(0xFF309358),
      lightRed: Color(0xFFF8D4D4),
      error: Color(0xFF912828),
    ),
  );

  static final lightTheme = _createTheme(
    Brightness.light,
    AppColors(
      background: Color(0xFFFFFFFF),
      primary: Color(0xFF3E79AE),
      secondary: Color(0xFFEBF1F6),
      accent: Color(0xFF737285),
      white: Color(0xFFFFFFFF),
      textColor: Color(0xFF5a5860),
      cardCompleted: Color(0xFFFFFFFF),
      cardNotCompleted: Color(0xFFFFFFFF),
      borderIcon: Color(0xFFCACACA),
      lightGreen: Color(0xFFD4F8D3),
      success: Color(0xFF309358),
      lightRed: Color(0xFFF8D4D4),
      error: Color(0xFF912828),
    ),
  );
}
