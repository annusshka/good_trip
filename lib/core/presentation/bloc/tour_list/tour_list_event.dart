import 'package:equatable/equatable.dart';

abstract class TourListEvent extends Equatable {
  const TourListEvent();
}

class TourListRequested extends TourListEvent {
  final String city;
  final double lat;
  final double lon;

  const TourListRequested(
      {this.city = "", this.lat = 0.0, this.lon = 0.0});

  @override
  List<Object> get props => [city, lat, lon];
}
