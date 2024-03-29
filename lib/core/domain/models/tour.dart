import 'dart:math';

class Tour {
  final String id;
  final String name;
  final String image;
  final DateTime? date;
  final Point coordinates;
  final String? description;
  final List<String> kinds;
  final List<String?> address;
  late bool isLiked;

  Tour({required this.id, required this.name, this.image = '',
    this.date, required this.coordinates, this.description, required this.kinds,
    required this.address, this.isLiked = false});

  Tour.undefined(): this(id: '', name: 'Воронеж',
      coordinates: const Point(39.1843, 51.672), kinds: [''], address: ['Россия', 'Воронеж']);
}