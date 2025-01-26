import 'package:flutter/material.dart';

class ExcursionPhoto extends StatelessWidget {
  const ExcursionPhoto({
    super.key,
    required this.photoUrl,
    required this.icon,
    required this.size,
    this.boxFit = BoxFit.cover,
  });

  final String? photoUrl;
  final IconData icon;
  final double size;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      photoUrl ?? '',
      fit: boxFit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey,
          alignment: Alignment.center,
          child: Icon(icon, size: size),
        );
      },
    );
  }
}
