import 'package:equatable/equatable.dart';

import '../../../data/models/models.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final LocationInfo weather;

  const WeatherLoadSuccess({required this.weather});

  @override
  List<Object> get props => [weather];
}

class WeatherLoadFailure extends WeatherState {
  final String errorMsg;

  const WeatherLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}