import 'package:flutter/material.dart';
import 'package:volt/core/constants/fonts.gen.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: FontFamily.cairo,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: AppColors.brandPrimary,
          ).copyWith(
            onSurface: AppColors.textPrimary,
          ),
    );
  }
}
