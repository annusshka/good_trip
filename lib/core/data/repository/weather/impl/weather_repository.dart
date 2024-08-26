import 'package:dio/dio.dart';
import 'package:good_trip/core/data/models/exception/weather_error.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/weather/i_weather_repository.dart';
import 'package:good_trip/core/data/service/service.dart';

class WeatherRepository implements IWeatherRepository {
  WeatherRepository({required this.service});

  final WeatherService service;

  @override
  Future<LocationInfo> fetchCurrentWeather(
      {String? query, double lat = 55.7522, double lon = 37.6156}) async {
    try {
      //int userId = await AuthRepository().loadUserId();
      final response = await service.fetchCurrentWeather(
        query: query,
        lat: lat,
        lon: lon,
      );

      return response;
    } on DioException catch (error) {
      throw WeatherError(
        name: 'FetchCurrentWeatherError',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    }
  }
}
