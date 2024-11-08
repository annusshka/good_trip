import 'package:flutter/material.dart';
import 'package:good_trip/core/data/api/api_key.dart';

class ExcursionPhoto extends StatelessWidget {
  const ExcursionPhoto({
    super.key,
    required this.photoUrl,
    required this.icon,
    required this.size,
  });

  final String? photoUrl;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      photoUrl != null && photoUrl!.contains('goodTrip') ?
      '$baseBDUrl/${photoUrl!}' : photoUrl ?? '',
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
