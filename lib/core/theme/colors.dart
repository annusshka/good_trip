import 'package:flutter/material.dart';

@immutable
class AppColors {
  final white = const Color(0xFFFFFFFF);
  final black = const Color(0x00000000);
  final lightGrayNavBar = const Color(0xFFCDD2DF);

  final lightGray1 = const Color.fromARGB(100, 241, 241, 245);
  final lightGray2 = const Color.fromARGB(100, 226, 226, 234);
  final lightGray = const Color.fromARGB(100, 181, 181, 190);
  final gray = const Color.fromARGB(100, 105, 105, 116);
  final darkGray2 = const Color.fromARGB(100, 0, 0, 20);
  final darkGray = const Color.fromARGB(100, 23, 23, 37);
  final pink_ = const Color.fromARGB(255, 255, 158, 162);

  /*
  final lightGray1 = const Color.fromRGBO(241, 241, 245, 1);
  final lightGray2 = const Color.fromRGBO(226, 226, 234, 1);
  final lightGray = const Color.fromRGBO(181, 181, 190, 1);
  final gray = const Color.fromRGBO(105, 105, 116, 1);
  final darkGray2 = const Color.fromRGBO(0, 0, 20, 1);
  final darkGray = const Color.fromRGBO(23, 23, 37, 1);
  final pink_ = const Color.fromARGB(255, 255, 158, 162);
   */

  const AppColors();
}