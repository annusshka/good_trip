import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/colors.dart';

const colors = AppColors();

final mainTheme = ThemeData(
  //primarySwatch: Colors.pink,
  colorScheme: ColorScheme.fromSeed(seedColor: colors.pink_),
  useMaterial3: true,
  fontFamily: 'Gilroy',
  textTheme: TextTheme(
    bodyLarge: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black
    ),
    bodyMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500, //medium
        color: colors.pink_,
    ),
    bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400, //regular
        color: colors.gray,
    ),
    titleLarge: const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: colors.darkGray,
    ),
    titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.lightGray,
    ),
    labelLarge: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600, // SemiBold
        color: Colors.black
    ),
    labelMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: colors.pink_,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: colors.gray,
    ),
  ),
);