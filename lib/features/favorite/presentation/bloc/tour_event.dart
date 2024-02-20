import 'package:equatable/equatable.dart';

abstract class TourEvent extends Equatable {
  const TourEvent();
}

class TourRequested extends TourEvent {
  final String city;
  final String lat;
  final String lon;

  const TourRequested({this.city = "", this.lat = "", this.lon = ""});

  @override
  List<Object> get props => [city];
}