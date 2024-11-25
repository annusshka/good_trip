import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/app_colors.dart';

import 'nav_bar_selected_icon.dart';

class NavBarElement extends StatelessWidget {
  const NavBarElement({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Icon(
        icon,
        color: AppColors.grayDF,
        size: 24,
      ),
      selectedIcon: NavBarSelectedIcon(icon: icon),
      label: 'Home',
    );
  }
}
