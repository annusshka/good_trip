import 'package:equatable/equatable.dart';

import '../../../domain/models/tour.dart';

abstract class TourEvent extends Equatable {
  const TourEvent();
}

class CurrentPositionRequested extends TourEvent {
  const CurrentPositionRequested();

  @override
  List<Object> get props => [];
}

class TourRequested extends TourEvent {
  final String city;
  final String lat;
  final String lon;
  final List<Tour> tourList;

  const TourRequested(
      {this.city = "", this.lat = "", this.lon = "", this.tourList = const []});

  @override
  List<Object> get props => [city, lat, lon, tourList];
}

class HomePageRequested extends TourEvent {
  final String city;
  final String lat;
  final String lon;
  final List<Tour> tourList;

  const HomePageRequested(
      {this.city = "", this.lat = "", this.lon = "", this.tourList = const []});

  @override
  List<Object> get props => [city, lat, lon, tourList];
}