import 'package:equatable/equatable.dart';

abstract class AudioTourEvent extends Equatable {
  const AudioTourEvent();
}

class AudioTourRequested extends AudioTourEvent {
  final String city;
  final double lat;
  final double lon;
  final int offset;

  const AudioTourRequested(
      {this.city = "Voronezh",
      this.lat = 0.0,
      this.lon = 0.0,
      this.offset = 0});

  @override
  List<Object> get props => [city, lat, lon];
}
