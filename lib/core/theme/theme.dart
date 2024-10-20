import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

final mainTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.pink),
  useMaterial3: true,
  fontFamily: 'Gilroy',
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: AppTextTheme.normal16,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.lightGrayEA,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    counterStyle: AppTextTheme.normal16,
  ),
);
