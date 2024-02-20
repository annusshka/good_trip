import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherRequested extends WeatherEvent {
  final String city;
  final String lat;
  final String lon;

  const WeatherRequested({this.city = "", this.lat = "", this.lon = ""});

  @override
  List<Object> get props => [city, lat, lon];
}

class WeatherCurrentPositionRequested extends WeatherEvent {
  final String city;
  final String lat;
  final String lon;

  const WeatherCurrentPositionRequested(
      {this.city = "", this.lat = "", this.lon = ""});

  @override
  List<Object> get props => [city];
}