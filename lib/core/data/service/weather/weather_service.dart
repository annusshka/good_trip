import 'package:dio/dio.dart';
import 'package:good_trip/core/data/api/api_key.dart';
import 'package:good_trip/core/data/models/models.dart';

class WeatherService {
  final Dio _dio;

  WeatherService({required Dio dio}) : _dio = dio;

  Future<LocationInfo> fetchCurrentWeather(
      {String? query, double lat = 55.7522, double lon = 37.6156}) async {
    if (query != null) {
      final geoUrl =
          'https://geocoding-api.open-meteo.com/v1/search?name=$query'
              '&count=1&language=ru&format=json';
      try {
        final response = await _dio.get(geoUrl);
        final results = response.data?['results'][0];
        if (results != null) {
          lat = results['latitude'];
          lon = results['longitude'];
        }
      } catch (_) {
        throw Exception('Failed to load weather');
      }
    }

    try {
      final String url = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat'
          '&lon=$lon&appid=$weatherApiKey&units=metric&lang=ru';
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return LocationInfo.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (_) {
      throw Exception('Failed to load weather');
    }
  }
}
