import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../widgets.dart';

class NavBarElement extends StatelessWidget {
  final IconData icon;
  const NavBarElement({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Icon(
        icon,
        color: colors.lightGrayNavBar,
        size: 24,
      ),
      selectedIcon: NavBarSelectedIcon(icon: icon),
      label: 'Home',
    );
  }
}
