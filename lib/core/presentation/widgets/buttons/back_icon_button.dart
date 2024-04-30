import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({super.key, required this.color, required this.iconSize});
  final Color color;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color,
      icon: const Icon(Icons.arrow_back_ios),
      iconSize: iconSize,
      onPressed: () {
        AutoRouter.of(context).back();
      },
    );
  }
}
