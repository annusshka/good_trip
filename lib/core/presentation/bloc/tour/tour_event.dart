import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class TourEvent extends Equatable {
  const TourEvent();
}

class WeatherRequested1 extends TourEvent {
  final String city;
  final String lat;
  final String lon;

  const WeatherRequested1(
      {this.city = "", this.lat = "", this.lon = ""});

  @override
  List<Object> get props => [city, lat, lon];
}

class CurrentPositionRequested extends TourEvent {
  const CurrentPositionRequested();

  @override
  List<Object> get props => [];
  /*
  final String city;
  final String lat;
  final String lon;

  const CurrentPositionRequested(
      {this.city = "", this.lat = "", this.lon = ""});

  @override
  List<Object> get props => [city, lat, lon];

   */
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