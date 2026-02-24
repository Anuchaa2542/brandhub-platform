// core/constants/app_text_styles.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brandhub/core/constants/app_sizes.dart';

class AppTextStyles {
  static TextStyle displayLg = GoogleFonts.inter(
    fontSize: AppSizes.displayLg,
    fontWeight: FontWeight.bold,
  );

  static TextStyle displayMd = GoogleFonts.inter(
    fontSize: AppSizes.displayMd,
    fontWeight: FontWeight.bold,
  );

  static TextStyle displaySm = GoogleFonts.inter(
    fontSize: AppSizes.displaySm,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h1 = GoogleFonts.inter(
    fontSize: AppSizes.h1,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h2 = GoogleFonts.inter(
    fontSize: AppSizes.h2,
    fontWeight: FontWeight.w700,
  );

  static TextStyle h3 = GoogleFonts.inter(
    fontSize: AppSizes.h3,
    fontWeight: FontWeight.w600,
  );

    static TextStyle h4 = GoogleFonts.inter(
      fontSize: AppSizes.h4,
      fontWeight: FontWeight.w500,
    );

  static TextStyle bodyLg = GoogleFonts.inter(
    fontSize: AppSizes.bodyLg,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodyMd = GoogleFonts.inter(
    fontSize: AppSizes.bodyMd,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodySm = GoogleFonts.inter(
    fontSize: AppSizes.bodySm,
    fontWeight: FontWeight.w400,
  );

  static TextStyle caption = GoogleFonts.inter(
    fontSize: AppSizes.caption,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );

  static TextStyle button = GoogleFonts.inter(
    fontSize: AppSizes.button,
    fontWeight: FontWeight.w600,
  );
}