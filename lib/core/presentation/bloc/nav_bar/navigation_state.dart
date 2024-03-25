import 'package:flutter/material.dart';

@immutable
abstract class NavigationState {
  final int tabIndex;

  const NavigationState({required this.tabIndex});
}

class PageInitial extends NavigationState {
  const PageInitial({required super.tabIndex});
}
