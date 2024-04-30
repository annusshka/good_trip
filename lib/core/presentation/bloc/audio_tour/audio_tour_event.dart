import 'package:equatable/equatable.dart';

abstract class AudioTourEvent extends Equatable {
  const AudioTourEvent();
}

class AudioTourRequested extends AudioTourEvent {
  final String city;
  final String lat;
  final String lon;

  const AudioTourRequested(
      {this.city = "", this.lat = "", this.lon = ""});

  @override
  List<Object> get props => [city, lat, lon];
}
