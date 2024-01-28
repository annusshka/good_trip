import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/models/models.dart';
import 'weather_event.dart';
import '../../data/repositories/weather_service.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
        if (event is WeatherCurrentPositionRequested) {
          _newWeatherCurrentPositionRequested(emit);
        } else if (event is WeatherRequested) {
          await _newWeatherRequested(event, emit);
        }
      },
    );
  }

  Future<void> _newWeatherRequested(
      WeatherRequested event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadInProgress());
    try {
      final Weather weather = await WeatherService.fetchCurrentWeather(
          query: event.city, lon: event.lon, lat: event.lat);
      emit(WeatherLoadSuccess(weather: weather));
    } catch (_) {
      emit(const WeatherLoadFailure(errorMsg: 'Error in weather request.'));
    }
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    /*
    Position? lastKnownPosition = await Geolocator.getLastKnownPosition();
    if(lastKnownPosition != null) {
      add(WeatherRequested(
          lat: lastKnownPosition.latitude.toString(),
          lon: lastKnownPosition.longitude.toString()));
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      add(WeatherRequested(
          lat: position.latitude.toString(),
          lon: position.longitude.toString()));
    }
     */

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    add(WeatherRequested(
        lat: position.latitude.toString(),
        lon: position.longitude.toString()));
  }

  void _newWeatherCurrentPositionRequested(Emitter<WeatherState> emit) async {
    emit(WeatherLoadInProgress());
    try {
      _determinePosition();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}