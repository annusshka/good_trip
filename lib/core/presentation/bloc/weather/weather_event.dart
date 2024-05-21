import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherRequested extends WeatherEvent {
  final String city;
  final double lat;
  final double lon;

  const WeatherRequested({this.city = "", this.lat = 0.0, this.lon = 0.0});

  @override
  List<Object> get props => [city, lat, lon];
}

class WeatherDefaultRequested extends WeatherEvent {
  final String city;
  final double lat;
  final double lon;

  const WeatherDefaultRequested(
      {this.city = "", this.lat = 59.855685, this.lon = 38.364285});

  @override
  List<Object> get props => [city, lat, lon];
}

class WeatherCurrentPositionRequested extends WeatherEvent {
  final String city;
  final double lat;
  final double lon;

  const WeatherCurrentPositionRequested(
      {this.city = "", this.lat = 0.0, this.lon = 0.0});

  @override
  List<Object> get props => [city];
}
