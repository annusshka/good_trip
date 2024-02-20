import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class NavBarSelectedIcon extends StatelessWidget {
  final IconData icon;
  const NavBarSelectedIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 18.0,
          height: 18.0,
          decoration: BoxDecoration(
            color: colors.pink_,
            shape: BoxShape.circle,
          ),
        ),
        Icon(icon, color: Colors.black, size: 24,),
      ],
    );
  }
}
