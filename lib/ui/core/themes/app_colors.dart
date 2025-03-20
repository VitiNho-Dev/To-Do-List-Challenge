import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color background;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color white;
  final Color textColor;
  final Color cardCompleted;
  final Color cardNotCompleted;
  final Color borderIcon;
  final Color lightGreen;
  final Color success;
  final Color lightRed;
  final Color error;

  const AppColors({
    required this.background,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.white,
    required this.textColor,
    required this.cardCompleted,
    required this.cardNotCompleted,
    required this.borderIcon,
    required this.lightGreen,
    required this.success,
    required this.lightRed,
    required this.error,
  });

  static AppColors of(BuildContext context) {
    return Theme.of(context).extension<AppColors>()!;
  }

  @override
  AppColors copyWith({
    Color? background,
    Color? primary,
    Color? secondary,
    Color? accent,
    Color? white,
    Color? textColor,
    Color? cardCompleted,
    Color? cardNotCompleted,
    Color? borderIcon,
    Color? lightGreen,
    Color? success,
    Color? lightRed,
    Color? error,
  }) {
    return AppColors(
      background: background ?? this.background,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      accent: accent ?? this.accent,
      white: white ?? this.white,
      textColor: textColor ?? this.textColor,
      cardCompleted: cardCompleted ?? this.cardCompleted,
      cardNotCompleted: cardNotCompleted ?? this.cardNotCompleted,
      borderIcon: borderIcon ?? this.borderIcon,
      lightGreen: lightGreen ?? this.lightGreen,
      success: success ?? this.success,
      lightRed: lightRed ?? this.lightRed,
      error: error ?? this.error,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      white: Color.lerp(white, other.white, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      cardCompleted: Color.lerp(cardCompleted, other.cardCompleted, t)!,
      cardNotCompleted:
          Color.lerp(cardNotCompleted, other.cardNotCompleted, t)!,
      borderIcon: Color.lerp(borderIcon, other.borderIcon, t)!,
      lightGreen: Color.lerp(lightGreen, other.lightGreen, t)!,
      success: Color.lerp(success, other.success, t)!,
      lightRed: Color.lerp(lightRed, other.lightRed, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}
