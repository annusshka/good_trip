import 'package:equatable/equatable.dart';

abstract class AudioExcursionListEvent extends Equatable {
  const AudioExcursionListEvent();
}

class AudioExcursionListRequested extends AudioExcursionListEvent {
  final String city;
  final double lat;
  final double lon;
  final int offset;

  const AudioExcursionListRequested(
      {this.city = 'Voronezh',
      this.lat = 0.0,
      this.lon = 0.0,
      this.offset = 0});

  @override
  List<Object> get props => [city, lat, lon];
}
