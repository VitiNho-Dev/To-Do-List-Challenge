import 'package:flutter/material.dart';

import 'colors.dart';

abstract final class AppTheme {
  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColorsDark.darkBlue2,
    primaryColor: AppColorsDark.cian,
    appBarTheme: AppBarTheme(backgroundColor: AppColorsDark.darkBlue2),
    iconTheme: IconThemeData(color: AppColorsDark.white, opacity: 1.0),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      filled: true,
      fillColor: AppColorsDark.darkBlue1,
      hintStyle: TextStyle(color: AppColorsDark.white, fontSize: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
