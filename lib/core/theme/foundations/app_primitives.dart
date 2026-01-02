
import 'package:flutter/material.dart';

abstract class AppPrimitives {
  // Common
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // Gray
  static const Color gray0 = black;
  static const Color gray5 = Color(0xFF0B0C0D);
  static const Color gray10 = Color(0xFF17181A);
  static const Color gray11 = Color(0xFF191A1D);
  static const Color gray15 = Color(0xFF232427);
  static const Color gray20 = Color(0xFF303134);
  static const Color gray25 = Color(0xFF3D3E41);
  static const Color gray30 = Color(0xFF4A4B4D);
  static const Color gray40 = Color(0xFF646567);
  static const Color gray50 = Color(0xFF7E7E80);
  static const Color gray60 = Color(0xFF989899);
  static const Color gray70 = Color(0xFFB1B2B3);
  static const Color gray80 = Color(0xFFCBCCCC);
  static const Color gray90 = Color(0xFFE5E5E6);
  static const Color gray95 = Color(0xFFF2F2F2);
  static const Color gray99 = Color(0xFFFCFCFC);
  static const Color gray100 = white;

  // Blue
  static const Color blue0 = black;
  static const Color blue5 = Color(0xFF050D17);
  static const Color blue10 = Color(0xFF09172A);
  static const Color blue15 = Color(0xFF0E233F);
  static const Color blue20 = Color(0xFF122F53);
  static const Color blue25 = Color(0xFF173A68);
  static const Color blue30 = Color(0xFF1B467D);
  static const Color blue40 = Color(0xFF245DA7);
  static const Color blue50 = Color(0xFF2E75CF);
  static const Color blue57 = Color(0xFF3485EE);
  static const Color blue60 = Color(0xFF4290F0);
  static const Color blue70 = Color(0xFF71AEF4);
  static const Color blue80 = Color(0xFFA1CBF8);
  static const Color blue90 = Color(0xFFD0E6FB);
  static const Color blue95 = Color(0xFFE7F3FD);
  static const Color blue99 = Color(0xFFFAFDFD);
  static const Color blue100 = white;

  // Red
  static const Color red0 = black;
  static const Color red5 = Color(0xFF140607);
  static const Color red10 = Color(0xFF280C0E);
  static const Color red15 = Color(0xFF3C1114);
  static const Color red20 = Color(0xFF50171B);
  static const Color red25 = Color(0xFF641D22);
  static const Color red30 = Color(0xFF772329);
  static const Color red40 = Color(0xFF9F2E36);
  static const Color red50 = Color(0xFFC73A44);
  static const Color red56 = Color(0xFFDF414C);
  static const Color red60 = Color(0xFFE2525C);
  static const Color red70 = Color(0xFFE97D85);
  static const Color red80 = Color(0xFFF0A9AE);
  static const Color red90 = Color(0xFFF8D4D6);
  static const Color red95 = Color(0xFFFBE9EB);
  static const Color red99 = Color(0xFFFEFBFB);
  static const Color red100 = white;

  // Orange
  static const Color orange0 = black;
  static const Color orange5 = Color(0xFF191005);
  static const Color orange10 = Color(0xFF332009);
  static const Color orange15 = Color(0xFF4C300E);
  static const Color orange20 = Color(0xFF664012);
  static const Color orange25 = Color(0xFF7F5017);
  static const Color orange30 = Color(0xFF99601C);
  static const Color orange40 = Color(0xFFCC7F25);
  static const Color orange50 = Color(0xFFD48F41);
  static const Color orange59 = Color(0xFFFF9F2E);
  static const Color orange60 = Color(0xFFFFA233);
  static const Color orange70 = Color(0xFFFFB966);
  static const Color orange80 = Color(0xFFFFD199);
  static const Color orange90 = Color(0xFFFFE7CC);
  static const Color orange95 = Color(0xFFFFF3E5);
  static const Color orange99 = Color(0xFFFFFCFB);
  static const Color orange100 = white;

  // Green
  static const Color green0 = black;
  static const Color green5 = Color(0xFF03150B);
  static const Color green10 = Color(0xFF072A16);
  static const Color green15 = Color(0xFF0A3F22);
  static const Color green20 = Color(0xFF0E542D);
  static const Color green25 = Color(0xFF116938);
  static const Color green30 = Color(0xFF157E43);
  static const Color green40 = Color(0xFF1CA859);
  static const Color green48 = Color(0xFF22D16F);
  static const Color green50 = Color(0xFF2BD676);
  static const Color green60 = Color(0xFF54EA92);
  static const Color green70 = Color(0xFF7FF0AE);
  static const Color green80 = Color(0xFFA9F5CA);
  static const Color green90 = Color(0xFFD4FAE5);
  static const Color green95 = Color(0xFFE9FDF2);
  static const Color green99 = Color(0xFFFBFEFE);
  static const Color green100 = white;

  // Gray Alpha (Base: #191A1D)
  static const Color grayAlpha0 = Color(0x00191A1D);
  static const Color grayAlpha5 = Color(0x0D191A1D); // 5% ~ 0D
  static const Color grayAlpha8 = Color(0x14191A1D); // 8% ~ 14
  static const Color grayAlpha12 = Color(0x1F191A1D); // 12% ~ 1F
  static const Color grayAlpha16 = Color(0x29191A1D); // 16% ~ 29
  static const Color grayAlpha22 = Color(0x38191A1D); // 22% ~ 38
  static const Color grayAlpha28 = Color(0x47191A1D); // 28% ~ 47
  static const Color grayAlpha35 = Color(0x59191A1D); // 35% ~ 59
  static const Color grayAlpha43 = Color(0x6E191A1D); // 43% ~ 6E
  static const Color grayAlpha52 = Color(0x85191A1D); // 52% ~ 85
  static const Color grayAlpha61 = Color(0x9C191A1D); // 61% ~ 9C
  static const Color grayAlpha74 = Color(0xBD191A1D); // 74% ~ BD
  static const Color grayAlpha88 = Color(0xE0191A1D); // 88% ~ E0
  static const Color grayAlpha97 = Color(0xF7191A1D); // 97% ~ F7
  static const Color grayAlpha100 = Color(0xFF191A1D);

  // White Alpha (Base: #FFFFFF)
  static const Color whiteAlpha0 = Color(0x00FFFFFF);
  static const Color whiteAlpha5 = Color(0x0DFFFFFF);
  static const Color whiteAlpha8 = Color(0x14FFFFFF);
  static const Color whiteAlpha12 = Color(0x1FFFFFFF);
  static const Color whiteAlpha16 = Color(0x29FFFFFF);
  static const Color whiteAlpha22 = Color(0x38FFFFFF);
  static const Color whiteAlpha28 = Color(0x47FFFFFF);
  static const Color whiteAlpha35 = Color(0x59FFFFFF);
  static const Color whiteAlpha43 = Color(0x6EFFFFFF);
  static const Color whiteAlpha52 = Color(0x85FFFFFF);
  static const Color whiteAlpha61 = Color(0x9CFFFFFF);
  static const Color whiteAlpha74 = Color(0xBDFFFFFF);
  static const Color whiteAlpha88 = Color(0xE0FFFFFF);
  static const Color whiteAlpha97 = Color(0xF7FFFFFF);
  static const Color whiteAlpha100 = white;
}
