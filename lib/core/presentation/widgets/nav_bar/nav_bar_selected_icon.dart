import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/app_colors.dart';

class NavBarSelectedIcon extends StatelessWidget {
  const NavBarSelectedIcon({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 18.0,
          height: 18.0,
          decoration: const BoxDecoration(
            color: AppColors.pink,
            shape: BoxShape.circle,
          ),
        ),
        Icon(icon, color: Colors.black, size: 24,),
      ],
    );
  }
}
