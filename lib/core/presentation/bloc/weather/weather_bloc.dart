import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/weather/i_weather_repository.dart';
import 'package:good_trip/core/data/service/service.dart';

import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final IWeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
        if (event is WeatherCurrentPositionRequested) {
          _weatherCurrentPositionRequested(emit);
        } else if (event is WeatherRequested) {
          await _weatherRequested(event, emit);
        }
      },
    );
  }

  Future<void> _weatherRequested(
      WeatherRequested event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadInProgress());
    try {
      final LocationInfo weather = await weatherRepository.fetchCurrentWeather(
          query: event.city, lon: event.lon, lat: event.lat);
      emit(WeatherLoadSuccess(weather: weather));
    } catch (_) {
      emit(const WeatherLoadFailure(errorMsg: 'Error in weather request.'));
    }
  }

  Future<void> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      add(const WeatherDefaultRequested());
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        add(const WeatherDefaultRequested());
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      add(const WeatherDefaultRequested());
      return Future.error('Location permissions are permanently denied, '
          'we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
    add(WeatherRequested(
        lat: position.latitude,
        lon: position.longitude
    ));
  }

  void _weatherCurrentPositionRequested(Emitter<WeatherState> emit) async {
    emit(WeatherLoadInProgress());
    try {
      _getCurrentPosition();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}