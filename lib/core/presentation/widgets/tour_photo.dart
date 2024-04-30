import 'package:flutter/material.dart';

class TourPhoto extends StatelessWidget {
  const TourPhoto({
    super.key,
    required this.photoUrl,
    required this.icon,
    required this.size,
  });

  final String photoUrl;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      photoUrl,
      fit: BoxFit.cover,
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
