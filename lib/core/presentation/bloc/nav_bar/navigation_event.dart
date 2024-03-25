import 'package:flutter/material.dart';

@immutable
abstract class NavigationEvent {
  const NavigationEvent();
}

class TabChange extends NavigationEvent {
  final int tabIndex;

  const TabChange({required this.tabIndex});
}
