import 'dart:math';

class Tour {
  final String id;
  final String name;
  final String? image;
  final DateTime? date;
  final Point coordinates;
  final String? description;
  final List<String> kinds;
  late bool isLiked = false;

  Tour({required this.id, required this.name, this.image,
    this.date, required this.coordinates,
    this.description, required this.kinds, this.isLiked = false});
}