import 'package:equatable/equatable.dart';

abstract class ExcursionListEvent extends Equatable {
  const ExcursionListEvent();
}

class ExcursionListRequested extends ExcursionListEvent {
  final String city;
  final double lat;
  final double lon;

  const ExcursionListRequested(
      {this.city = '', this.lat = 0.0, this.lon = 0.0});

  @override
  List<Object> get props => [city, lat, lon];
}
