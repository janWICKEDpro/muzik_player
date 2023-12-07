import 'package:flutter/material.dart';
import 'package:muzik_player/themes/colors.dart';

class MuzikPlayerTheme {
  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: _colorScheme,
    );
  }

  static ColorScheme get _colorScheme {
    return ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlack, brightness: Brightness.dark);
  }
}
