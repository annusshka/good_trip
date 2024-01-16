import 'dart:math';

class Event {
  final String id;
  final String name;
  final String? image;
  final DateTime? date;
  final Point coordinates;
  final String? description;
  final List<String> kinds;

  Event({required this.id, required this.name, this.image,
    this.date, required this.coordinates,
    this.description, required this.kinds});
}