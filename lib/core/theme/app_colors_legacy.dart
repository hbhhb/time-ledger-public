import 'package:flutter/material.dart';

@Deprecated('Use AppPrimitives and AppTokens instead')
abstract class AppColorsLegacy {
  // Backgrounds
  static const Color bgPrimary = Color(0xFFFFFFFF); 
  static const Color bgSecondary = Color(0xFFF5F5F7);
  static const Color bgInverseSecondary = Color(0xFF313236);

  // Foregrounds (Text/Icons)
  static const Color fgPrimary = Color(0xFF191A1D);
  static const Color fgSecondary = Color(0xFF313236);
  static const Color fgTertiary = Color(0xFF7E8088);
  static const Color fgInverse = Color(0xFFF8F8F9);
  static const Color fgSlight = Color(0xFFE7E8EC);
  
  // Accents & Functional
  static const Color destructive = Color(0xFFDF414C);
  static const Color fgRevenuePrimary = Color(0xFF149176); // Greenish
  
  // Steps/Grass (Activity Levels)
  static const Color stepGrassLv1 = Color(0xFFBDC0C7);
  static const Color stepGrassLv2 = Color(0xFF6B7078);
  static const Color stepGrassLv3 = Color(0xFF313236);
  static const Color stepGrassLv4 = Color(0xFF191A1D);

  // Functional Colors
  static const Color error = Color(0xFFDF414C);
  static const Color brandPrimary = Color(0xFF191A1D); // Primary Black
  static const Color borderDefault = Color(0xFFE7E8EC);
}
