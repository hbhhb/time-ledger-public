import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:time_ledger/core/theme/foundations/app_primitives.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  // Primary
  final Color primaryNormal;

  // Label
  final Color labelNormal;
  final Color labelStrong;
  final Color labelNeutral;
  final Color labelAlternative;
  final Color labelAssistive;
  final Color labelDisable;

  // Background
  final Color backgroundNormalNormal;
  final Color backgroundNormalAlternative;
  final Color backgroundElevatedNormal;
  final Color backgroundElevatedAlternative;

  // Interaction
  final Color interactionInactive;
  final Color interactionDisable;

  // Line
  final Color lineNormalNormal;
  final Color lineNormalNeutral;
  final Color lineNormalAlternative;
  final Color lineSolidNormal;
  final Color lineSolidNeutral;
  final Color lineSolidAlternative;

  // Status
  final Color statusPositive;
  final Color statusCautionary;
  final Color statusNegative;

  // Grass
  final Color grassLv4;
  final Color grassLv3;
  final Color grassLv2;
  final Color grassLv1;

  // Inverse
  final Color inversePrimary;
  final Color inverseBackground;
  final Color inverseLabel;

  const AppColors({
    required this.primaryNormal,
    required this.labelNormal,
    required this.labelStrong,
    required this.labelNeutral,
    required this.labelAlternative,
    required this.labelAssistive,
    required this.labelDisable,
    required this.backgroundNormalNormal,
    required this.backgroundNormalAlternative,
    required this.backgroundElevatedNormal,
    required this.backgroundElevatedAlternative,
    required this.interactionInactive,
    required this.interactionDisable,
    required this.lineNormalNormal,
    required this.lineNormalNeutral,
    required this.lineNormalAlternative,
    required this.lineSolidNormal,
    required this.lineSolidNeutral,
    required this.lineSolidAlternative,
    required this.statusPositive,
    required this.statusCautionary,
    required this.statusNegative,
    required this.inversePrimary,
    required this.inverseBackground,
    required this.inverseLabel,
    required this.grassLv4,
    required this.grassLv3,
    required this.grassLv2,
    required this.grassLv1,
  });

  factory AppColors.light() {
    return const AppColors(
      primaryNormal: AppPrimitives.gray11,
      labelNormal: AppPrimitives.gray11,
      labelStrong: AppPrimitives.black,
      labelNeutral: AppPrimitives.grayAlpha88,
      labelAlternative: AppPrimitives.grayAlpha52,
      labelAssistive: AppPrimitives.grayAlpha28,
      labelDisable: AppPrimitives.grayAlpha16,
      backgroundNormalNormal: AppPrimitives.white,
      backgroundNormalAlternative: AppPrimitives.gray99,
      backgroundElevatedNormal: AppPrimitives.white,
      backgroundElevatedAlternative: AppPrimitives.gray99,
      interactionInactive: AppPrimitives.gray70,
      interactionDisable: AppPrimitives.gray95,
      lineNormalNormal: AppPrimitives.grayAlpha12,
      lineNormalNeutral: AppPrimitives.grayAlpha8,
      lineNormalAlternative: AppPrimitives.grayAlpha5,
      lineSolidNormal: AppPrimitives.gray95,
      lineSolidNeutral: AppPrimitives.gray90,
      lineSolidAlternative: AppPrimitives.gray80,
      statusPositive: AppPrimitives.green48,
      statusCautionary: AppPrimitives.orange59,
      statusNegative: AppPrimitives.red56,
      inversePrimary: AppPrimitives.white,
      inverseBackground: AppPrimitives.gray11,
      inverseLabel: AppPrimitives.white,
      grassLv4: AppPrimitives.gray5,
      grassLv3: AppPrimitives.gray30,
      grassLv2: AppPrimitives.gray60,
      grassLv1: AppPrimitives.gray90,
    );
  }

  factory AppColors.dark() {
    return const AppColors(
      primaryNormal: AppPrimitives.gray90,
      labelNormal: AppPrimitives.gray99,
      labelStrong: AppPrimitives.white,
      labelNeutral: AppPrimitives.whiteAlpha88,
      labelAlternative: AppPrimitives.whiteAlpha52,
      labelAssistive: AppPrimitives.whiteAlpha28,
      labelDisable: AppPrimitives.whiteAlpha16,
      backgroundNormalNormal: AppPrimitives.gray11,
      backgroundNormalAlternative: AppPrimitives.gray5,
      backgroundElevatedNormal: AppPrimitives.gray15,
      backgroundElevatedAlternative: AppPrimitives.gray20,
      interactionInactive: AppPrimitives.gray40,
      interactionDisable: AppPrimitives.gray25,
      lineNormalNormal: AppPrimitives.whiteAlpha16,
      lineNormalNeutral: AppPrimitives.whiteAlpha12,
      lineNormalAlternative: AppPrimitives.whiteAlpha8,
      lineSolidNormal: AppPrimitives.gray25,
      lineSolidNeutral: AppPrimitives.gray20,
      lineSolidAlternative: AppPrimitives.gray15,
      statusPositive: AppPrimitives.green60,
      statusCautionary: AppPrimitives.orange70,
      statusNegative: AppPrimitives.red70,
      inversePrimary: AppPrimitives.gray11,
      inverseBackground: AppPrimitives.white,
      inverseLabel: AppPrimitives.gray11,
      grassLv4: AppPrimitives.gray90,
      grassLv3: AppPrimitives.gray60,
      grassLv2: AppPrimitives.gray30,
      grassLv1: AppPrimitives.gray15,
    );
  }

  @override
  AppColors copyWith({
    Color? primaryNormal,
    Color? labelNormal,
    Color? labelStrong,
    Color? labelNeutral,
    Color? labelAlternative,
    Color? labelAssistive,
    Color? labelDisable,
    Color? backgroundNormalNormal,
    Color? backgroundNormalAlternative,
    Color? backgroundElevatedNormal,
    Color? backgroundElevatedAlternative,
    Color? interactionInactive,
    Color? interactionDisable,
    Color? lineNormalNormal,
    Color? lineNormalNeutral,
    Color? lineNormalAlternative,
    Color? lineSolidNormal,
    Color? lineSolidNeutral,
    Color? lineSolidAlternative,
    Color? statusPositive,
    Color? statusCautionary,
    Color? statusNegative,
    Color? inversePrimary,
    Color? inverseBackground,
    Color? inverseLabel,
    Color? grassLv4,
    Color? grassLv3,
    Color? grassLv2,
    Color? grassLv1,
  }) {
    return AppColors(
      primaryNormal: primaryNormal ?? this.primaryNormal,
      labelNormal: labelNormal ?? this.labelNormal,
      labelStrong: labelStrong ?? this.labelStrong,
      labelNeutral: labelNeutral ?? this.labelNeutral,
      labelAlternative: labelAlternative ?? this.labelAlternative,
      labelAssistive: labelAssistive ?? this.labelAssistive,
      labelDisable: labelDisable ?? this.labelDisable,
      backgroundNormalNormal: backgroundNormalNormal ?? this.backgroundNormalNormal,
      backgroundNormalAlternative: backgroundNormalAlternative ?? this.backgroundNormalAlternative,
      backgroundElevatedNormal: backgroundElevatedNormal ?? this.backgroundElevatedNormal,
      backgroundElevatedAlternative: backgroundElevatedAlternative ?? this.backgroundElevatedAlternative,
      interactionInactive: interactionInactive ?? this.interactionInactive,
      interactionDisable: interactionDisable ?? this.interactionDisable,
      lineNormalNormal: lineNormalNormal ?? this.lineNormalNormal,
      lineNormalNeutral: lineNormalNeutral ?? this.lineNormalNeutral,
      lineNormalAlternative: lineNormalAlternative ?? this.lineNormalAlternative,
      lineSolidNormal: lineSolidNormal ?? this.lineSolidNormal,
      lineSolidNeutral: lineSolidNeutral ?? this.lineSolidNeutral,
      lineSolidAlternative: lineSolidAlternative ?? this.lineSolidAlternative,
      statusPositive: statusPositive ?? this.statusPositive,
      statusCautionary: statusCautionary ?? this.statusCautionary,
      statusNegative: statusNegative ?? this.statusNegative,
      inversePrimary: inversePrimary ?? this.inversePrimary,
      inverseBackground: inverseBackground ?? this.inverseBackground,
      inverseLabel: inverseLabel ?? this.inverseLabel,
      grassLv4: grassLv4 ?? this.grassLv4,
      grassLv3: grassLv3 ?? this.grassLv3,
      grassLv2: grassLv2 ?? this.grassLv2,
      grassLv1: grassLv1 ?? this.grassLv1,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primaryNormal: Color.lerp(primaryNormal, other.primaryNormal, t)!,
      labelNormal: Color.lerp(labelNormal, other.labelNormal, t)!,
      labelStrong: Color.lerp(labelStrong, other.labelStrong, t)!,
      labelNeutral: Color.lerp(labelNeutral, other.labelNeutral, t)!,
      labelAlternative: Color.lerp(labelAlternative, other.labelAlternative, t)!,
      labelAssistive: Color.lerp(labelAssistive, other.labelAssistive, t)!,
      labelDisable: Color.lerp(labelDisable, other.labelDisable, t)!,
      backgroundNormalNormal: Color.lerp(backgroundNormalNormal, other.backgroundNormalNormal, t)!,
      backgroundNormalAlternative: Color.lerp(backgroundNormalAlternative, other.backgroundNormalAlternative, t)!,
      backgroundElevatedNormal: Color.lerp(backgroundElevatedNormal, other.backgroundElevatedNormal, t)!,
      backgroundElevatedAlternative: Color.lerp(backgroundElevatedAlternative, other.backgroundElevatedAlternative, t)!,
      interactionInactive: Color.lerp(interactionInactive, other.interactionInactive, t)!,
      interactionDisable: Color.lerp(interactionDisable, other.interactionDisable, t)!,
      lineNormalNormal: Color.lerp(lineNormalNormal, other.lineNormalNormal, t)!,
      lineNormalNeutral: Color.lerp(lineNormalNeutral, other.lineNormalNeutral, t)!,
      lineNormalAlternative: Color.lerp(lineNormalAlternative, other.lineNormalAlternative, t)!,
      lineSolidNormal: Color.lerp(lineSolidNormal, other.lineSolidNormal, t)!,
      lineSolidNeutral: Color.lerp(lineSolidNeutral, other.lineSolidNeutral, t)!,
      lineSolidAlternative: Color.lerp(lineSolidAlternative, other.lineSolidAlternative, t)!,
      statusPositive: Color.lerp(statusPositive, other.statusPositive, t)!,
      statusCautionary: Color.lerp(statusCautionary, other.statusCautionary, t)!,
      statusNegative: Color.lerp(statusNegative, other.statusNegative, t)!,
      inversePrimary: Color.lerp(inversePrimary, other.inversePrimary, t)!,
      inverseBackground: Color.lerp(inverseBackground, other.inverseBackground, t)!,
      inverseLabel: Color.lerp(inverseLabel, other.inverseLabel, t)!,
      grassLv4: Color.lerp(grassLv4, other.grassLv4, t)!,
      grassLv3: Color.lerp(grassLv3, other.grassLv3, t)!,
      grassLv2: Color.lerp(grassLv2, other.grassLv2, t)!,
      grassLv1: Color.lerp(grassLv1, other.grassLv1, t)!,
    );
  }
}

@immutable
class AppOpacity extends ThemeExtension<AppOpacity> {
  // Normal
  final double hoverNormal;
  final double focusedNormal;
  final double pressedNormal;

  // Light
  final double hoverLight;
  final double focusedLight;
  final double pressedLight;

  // Strong
  final double hoverStrong;
  final double focusedStrong;
  final double pressedStrong;

  const AppOpacity({
    required this.hoverNormal,
    required this.focusedNormal,
    required this.pressedNormal,
    required this.hoverLight,
    required this.focusedLight,
    required this.pressedLight,
    required this.hoverStrong,
    required this.focusedStrong,
    required this.pressedStrong,
  });

  factory AppOpacity.values() {
    return const AppOpacity(
      hoverNormal: 0.05,
      focusedNormal: 0.08,
      pressedNormal: 0.12,
      hoverLight: 0.04,
      focusedLight: 0.05,
      pressedLight: 0.08,
      hoverStrong: 0.08,
      focusedStrong: 0.12,
      pressedStrong: 0.20,
    );
  }

  @override
  AppOpacity copyWith({
    double? hoverNormal,
    double? focusedNormal,
    double? pressedNormal,
    double? hoverLight,
    double? focusedLight,
    double? pressedLight,
    double? hoverStrong,
    double? focusedStrong,
    double? pressedStrong,
  }) {
    return AppOpacity(
      hoverNormal: hoverNormal ?? this.hoverNormal,
      focusedNormal: focusedNormal ?? this.focusedNormal,
      pressedNormal: pressedNormal ?? this.pressedNormal,
      hoverLight: hoverLight ?? this.hoverLight,
      focusedLight: focusedLight ?? this.focusedLight,
      pressedLight: pressedLight ?? this.pressedLight,
      hoverStrong: hoverStrong ?? this.hoverStrong,
      focusedStrong: focusedStrong ?? this.focusedStrong,
      pressedStrong: pressedStrong ?? this.pressedStrong,
    );
  }

  @override
  AppOpacity lerp(ThemeExtension<AppOpacity>? other, double t) {
    if (other is! AppOpacity) return this;
    return AppOpacity(
      hoverNormal: lerpDouble(hoverNormal, other.hoverNormal, t)!,
      focusedNormal: lerpDouble(focusedNormal, other.focusedNormal, t)!,
      pressedNormal: lerpDouble(pressedNormal, other.pressedNormal, t)!,
      hoverLight: lerpDouble(hoverLight, other.hoverLight, t)!,
      focusedLight: lerpDouble(focusedLight, other.focusedLight, t)!,
      pressedLight: lerpDouble(pressedLight, other.pressedLight, t)!,
      hoverStrong: lerpDouble(hoverStrong, other.hoverStrong, t)!,
      focusedStrong: lerpDouble(focusedStrong, other.focusedStrong, t)!,
      pressedStrong: lerpDouble(pressedStrong, other.pressedStrong, t)!,

    );
  }
}

@immutable
class AppShadows extends ThemeExtension<AppShadows> {
  final List<BoxShadow> spreadStrong;

  const AppShadows({
    required this.spreadStrong,
  });

  factory AppShadows.values() {
    return const AppShadows(
      spreadStrong: [
        BoxShadow(
          color: Color(0x0A000000), // 4%
          offset: Offset(0, 0),
          blurRadius: 8,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: Color(0x14000000), // 8%
          offset: Offset(0, 4),
          blurRadius: 16,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: Color(0x1F000000), // 12%
          offset: Offset(0, 6),
          blurRadius: 24,
          spreadRadius: 0,
        ),
      ],
    );
  }

  @override
  AppShadows copyWith({List<BoxShadow>? spreadStrong}) {
    return AppShadows(
      spreadStrong: spreadStrong ?? this.spreadStrong,
    );
  }

  @override
  AppShadows lerp(ThemeExtension<AppShadows>? other, double t) {
    if (other is! AppShadows) return this;
    return AppShadows(
      spreadStrong: BoxShadow.lerpList(spreadStrong, other.spreadStrong, t)!,
    );
  }
}
