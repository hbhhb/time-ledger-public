import 'package:flutter/material.dart';

@immutable
class AppTextStyle {
  final TextStyle regular;
  final TextStyle medium;
  final TextStyle bold;
  final AppTextStyle? reading;

  const AppTextStyle({
    required this.regular,
    required this.medium,
    required this.bold,
    this.reading,
  });

  factory AppTextStyle.from({
    required String fontFamily,
    required double fontSize,
    required double height,
    required double letterSpacingPercent, // %
    required FontWeight boldWeight, // w700 or w600
  }) {
    final double letterSpacing = fontSize * (letterSpacingPercent / 100);

    return AppTextStyle(
      regular: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        height: height,
        letterSpacing: letterSpacing,
        fontWeight: FontWeight.w400,
      ),
      medium: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        height: height,
        letterSpacing: letterSpacing,
        fontWeight: FontWeight.w500,
      ),
      bold: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        height: height,
        letterSpacing: letterSpacing,
        fontWeight: boldWeight,
      ),
    );
  }

  AppTextStyle copyWith({
    TextStyle? regular,
    TextStyle? medium,
    TextStyle? bold,
    AppTextStyle? reading,
  }) {
    return AppTextStyle(
      regular: regular ?? this.regular,
      medium: medium ?? this.medium,
      bold: bold ?? this.bold,
      reading: reading ?? this.reading,
    );
  }

  static AppTextStyle? lerp(AppTextStyle? a, AppTextStyle? b, double t) {
    if (a == null && b == null) return null;
    return AppTextStyle(
      regular: TextStyle.lerp(a?.regular, b?.regular, t) ?? const TextStyle(),
      medium: TextStyle.lerp(a?.medium, b?.medium, t) ?? const TextStyle(),
      bold: TextStyle.lerp(a?.bold, b?.bold, t) ?? const TextStyle(),
      reading: AppTextStyle.lerp(a?.reading, b?.reading, t),
    );
  }
}

@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  static const String fontFamily = 'Pretendard';

  // Display
  final AppTextStyle display1;
  final AppTextStyle display2;

  // Title
  final AppTextStyle title1;
  final AppTextStyle title2;
  final AppTextStyle title3;

  // Heading
  final AppTextStyle heading1;
  final AppTextStyle heading2;

  // Headline
  final AppTextStyle headline1;
  final AppTextStyle headline2;

  // Body
  final AppTextStyle body1;
  final AppTextStyle body2;

  // Label
  final AppTextStyle label1;
  final AppTextStyle label2;

  // Caption
  final AppTextStyle caption1;
  final AppTextStyle caption2;

  const AppTypography({
    required this.display1,
    required this.display2,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.heading1,
    required this.heading2,
    required this.headline1,
    required this.headline2,
    required this.body1,
    required this.body2,
    required this.label1,
    required this.label2,
    required this.caption1,
    required this.caption2,
  });

  factory AppTypography.regular() {
    return AppTypography(
      // Display (Bold = w700)
      display1: AppTextStyle.from(
          fontFamily: fontFamily, fontSize: 56, height: 1.286, letterSpacingPercent: -3.19, boldWeight: FontWeight.w700),
      display2: AppTextStyle.from(
          fontFamily: fontFamily, fontSize: 40, height: 1.300, letterSpacingPercent: -2.82, boldWeight: FontWeight.w700),

      // Title (Bold = w700)
      title1: AppTextStyle.from(
          fontFamily: fontFamily, fontSize: 36, height: 1.334, letterSpacingPercent: -2.70, boldWeight: FontWeight.w700),
      title2: AppTextStyle.from(
          fontFamily: fontFamily, fontSize: 28, height: 1.358, letterSpacingPercent: -2.36, boldWeight: FontWeight.w700),
      title3: AppTextStyle.from(
          fontFamily: fontFamily, fontSize: 24, height: 1.334, letterSpacingPercent: -2.30, boldWeight: FontWeight.w700),

      // Heading (Bold = w600 SemiBold)
      heading1: AppTextStyle.from(
          fontFamily: fontFamily, fontSize: 22, height: 1.364, letterSpacingPercent: -1.94, boldWeight: FontWeight.w600),
      heading2: AppTextStyle.from(
          fontFamily: fontFamily, fontSize: 20, height: 1.400, letterSpacingPercent: -1.20, boldWeight: FontWeight.w600),

      // Headline (Bold = w600 SemiBold)
      headline1: AppTextStyle.from(
          fontFamily: fontFamily, fontSize: 18, height: 1.445, letterSpacingPercent: -0.02, boldWeight: FontWeight.w600),
      headline2: AppTextStyle.from(
          fontFamily: fontFamily, fontSize: 17, height: 1.412, letterSpacingPercent: 0.00, boldWeight: FontWeight.w600),

      // Body (Bold = w600 SemiBold)
      body1: AppTextStyle.from(
        fontFamily: fontFamily, fontSize: 16, height: 1.500, letterSpacingPercent: 0.57, boldWeight: FontWeight.w600,
      ).copyWith(
        reading: AppTextStyle.from(
            fontFamily: fontFamily, fontSize: 16, height: 1.625, letterSpacingPercent: 0.57, boldWeight: FontWeight.w600),
      ),
      body2: AppTextStyle.from(
        fontFamily: fontFamily, fontSize: 15, height: 1.467, letterSpacingPercent: 0.96, boldWeight: FontWeight.w600,
      ).copyWith(
        reading: AppTextStyle.from(
            fontFamily: fontFamily, fontSize: 15, height: 1.600, letterSpacingPercent: 0.96, boldWeight: FontWeight.w600),
      ),

      // Label (Bold = w600 SemiBold)
      label1: AppTextStyle.from(
        fontFamily: fontFamily, fontSize: 14, height: 1.429, letterSpacingPercent: 1.45, boldWeight: FontWeight.w600,
      ).copyWith(
        reading: AppTextStyle.from(
            fontFamily: fontFamily, fontSize: 14, height: 1.571, letterSpacingPercent: 1.45, boldWeight: FontWeight.w600),
      ),
      label2: AppTextStyle.from(
          fontFamily: fontFamily, fontSize: 13, height: 1.385, letterSpacingPercent: 1.94, boldWeight: FontWeight.w600),

      // Caption (Bold = w600 SemiBold)
      caption1: AppTextStyle.from(
          fontFamily: fontFamily, fontSize: 12, height: 1.334, letterSpacingPercent: 2.52, boldWeight: FontWeight.w600),
      caption2: AppTextStyle.from(
          fontFamily: fontFamily, fontSize: 11, height: 1.273, letterSpacingPercent: 3.11, boldWeight: FontWeight.w600),
    );
  }

  @override
  AppTypography copyWith({
    AppTextStyle? display1,
    AppTextStyle? display2,
    AppTextStyle? title1,
    AppTextStyle? title2,
    AppTextStyle? title3,
    AppTextStyle? heading1,
    AppTextStyle? heading2,
    AppTextStyle? headline1,
    AppTextStyle? headline2,
    AppTextStyle? body1,
    AppTextStyle? body2,
    AppTextStyle? label1,
    AppTextStyle? label2,
    AppTextStyle? caption1,
    AppTextStyle? caption2,
  }) {
    return AppTypography(
      display1: display1 ?? this.display1,
      display2: display2 ?? this.display2,
      title1: title1 ?? this.title1,
      title2: title2 ?? this.title2,
      title3: title3 ?? this.title3,
      heading1: heading1 ?? this.heading1,
      heading2: heading2 ?? this.heading2,
      headline1: headline1 ?? this.headline1,
      headline2: headline2 ?? this.headline2,
      body1: body1 ?? this.body1,
      body2: body2 ?? this.body2,
      label1: label1 ?? this.label1,
      label2: label2 ?? this.label2,
      caption1: caption1 ?? this.caption1,
      caption2: caption2 ?? this.caption2,
    );
  }

  @override
  AppTypography lerp(ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) return this;
    return AppTypography(
      display1: AppTextStyle.lerp(display1, other.display1, t)!,
      display2: AppTextStyle.lerp(display2, other.display2, t)!,
      title1: AppTextStyle.lerp(title1, other.title1, t)!,
      title2: AppTextStyle.lerp(title2, other.title2, t)!,
      title3: AppTextStyle.lerp(title3, other.title3, t)!,
      heading1: AppTextStyle.lerp(heading1, other.heading1, t)!,
      heading2: AppTextStyle.lerp(heading2, other.heading2, t)!,
      headline1: AppTextStyle.lerp(headline1, other.headline1, t)!,
      headline2: AppTextStyle.lerp(headline2, other.headline2, t)!,
      body1: AppTextStyle.lerp(body1, other.body1, t)!,
      body2: AppTextStyle.lerp(body2, other.body2, t)!,
      label1: AppTextStyle.lerp(label1, other.label1, t)!,
      label2: AppTextStyle.lerp(label2, other.label2, t)!,
      caption1: AppTextStyle.lerp(caption1, other.caption1, t)!,
      caption2: AppTextStyle.lerp(caption2, other.caption2, t)!,
    );
  }
}
