import 'package:equatable/equatable.dart';

abstract class TourListEvent extends Equatable {
  const TourListEvent();
}

class TourLikeRequested extends TourListEvent {
  final String id;
  final bool isLiked;

  const TourLikeRequested({required this.id, required this.isLiked});

  @override
  List<Object> get props => [id];
}

class TourListRequested extends TourListEvent {
  final String city;
  final double lat;
  final double lon;
  final int offset;

  const TourListRequested({
    this.city = 'Voronezh',
    this.lat = 0.0,
    this.lon = 0.0,
    this.offset = 0,
  });

  @override
  List<Object> get props => [city, lat, lon];
}
