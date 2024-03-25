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

class WeatherDefaultRequested extends WeatherEvent {
  final String city;
  final String lat;
  final String lon;

  const WeatherDefaultRequested({this.city = "", this.lat = "59.855685", this.lon = "38.364285"});

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