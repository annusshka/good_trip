import 'package:dio/dio.dart';
import 'package:good_trip/core/data/models/models.dart';

import '../api/api_key.dart';


class WeatherService {

  static Future<LocationInfo> fetchCurrentWeather({query,
    String lat = "", String lon =""}) async {
    var url = 'http://api.openweathermap.org/data/2.5/weather?q=$query'
        '&lat=$lat&lon=$lon&appid=$weatherApiKey&units=metric&lang=ru';
    final response = await Dio().post(url);

    if (response.statusCode == 200) {
      return LocationInfo.fromJson(response.data);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}