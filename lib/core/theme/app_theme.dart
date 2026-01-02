import 'package:flutter/material.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/core/theme/foundations/app_tokens.dart';
import 'package:time_ledger/core/theme/foundations/app_typography.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Pretendard',
      
      extensions: <ThemeExtension<dynamic>>[
        AppColors.light(),
        AppTypography.regular(),
        AppShadows.values(),
      ],
      
      // Color Scheme Override
      colorScheme: const ColorScheme.light(
        primary: AppColorsLegacy.fgPrimary,
        onPrimary: AppColorsLegacy.fgInverse,
        secondary: AppColorsLegacy.fgSecondary,
        onSecondary: AppColorsLegacy.fgInverse,
        surface: AppColorsLegacy.bgPrimary,
        onSurface: AppColorsLegacy.fgPrimary,
        error: AppColorsLegacy.destructive,
        onError: Colors.white,
        background: AppColorsLegacy.bgPrimary,
        onBackground: AppColorsLegacy.fgPrimary,
      ),
      
      scaffoldBackgroundColor: AppColorsLegacy.bgPrimary,
      
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColorsLegacy.bgPrimary,
        foregroundColor: AppColorsLegacy.fgPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      
      // Additional customizations can go here (TextTheme, ElevatedButtonTheme, etc.)
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Pretendard',
      
      extensions: <ThemeExtension<dynamic>>[
        AppColors.dark(),
        AppTypography.regular(),
        AppShadows.values(),
      ],
      
      // Legacy Fallback for Dark Mode (Warning: Legacy colors are Light-only)
      colorScheme: const ColorScheme.dark(
        primary: AppColorsLegacy.fgPrimary,
        surface: AppColorsLegacy.bgPrimary,
        background: AppColorsLegacy.bgPrimary,
        error: AppColorsLegacy.destructive,
      ),
      
      scaffoldBackgroundColor: AppColorsLegacy.bgPrimary,
    );
  }
}
