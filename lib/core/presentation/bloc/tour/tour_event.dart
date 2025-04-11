import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class TourEvent extends Equatable {
  const TourEvent();
}

class TourRequested extends TourEvent {
  final Tour tour;

  const TourRequested({required this.tour});

  @override
  List<Object> get props => [tour];
}

class TourLikeRequested extends TourEvent {
  final String id;

  const TourLikeRequested({required this.id});

  @override
  List<Object> get props => [id];
}

class TourSaveRequested extends TourEvent {
  final Tour tour;

  const TourSaveRequested({required this.tour});

  @override
  List<Object> get props => [tour];
}

class TourListRequested extends TourEvent {
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
