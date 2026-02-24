// core/constants/app_radius.dart
import 'package:brandhub/core/extensions/app_num_extension.dart';
import 'package:flutter/material.dart';

class AppRadius {
  static double get xs => 4.r;
  static double get sm => 8.r;
  static double get md => 12.r;
  static double get lg => 16.r;
  static double get xl => 24.r;
  static double get xxl => 32.r;

  static BorderRadius get allXs => BorderRadius.circular(xs);
  static BorderRadius get allSm => BorderRadius.circular(sm);
  static BorderRadius get allMd => BorderRadius.circular(md);
  static BorderRadius get allLg => BorderRadius.circular(lg);
  static BorderRadius get allXl => BorderRadius.circular(xl);
  static BorderRadius get allXxl => BorderRadius.circular(xxl);
}