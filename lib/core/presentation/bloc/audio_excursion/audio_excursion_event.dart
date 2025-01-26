import 'package:equatable/equatable.dart';

abstract class AudioExcursionEvent extends Equatable {
  const AudioExcursionEvent();
}

class AudioExcursionRequested extends AudioExcursionEvent {
  final String city;
  final double lat;
  final double lon;
  final int offset;

  const AudioExcursionRequested(
      {this.city = 'Voronezh',
      this.lat = 0.0,
      this.lon = 0.0,
      this.offset = 0});

  @override
  List<Object> get props => [city, lat, lon];
}
