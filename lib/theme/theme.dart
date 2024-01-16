import 'package:flutter/material.dart';

final mainTheme = ThemeData(
  //primarySwatch: Colors.pink,
  //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(
      255, 255, 158, 162)),
  useMaterial3: true,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 14
    ),
  ),
);