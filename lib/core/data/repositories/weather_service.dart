import 'package:dio/dio.dart';
import 'package:good_trip/core/data/models/models.dart';

import 'event/event.dart';


class WeatherService {

  static Future<Weather> fetchCurrentWeather({query, String lat = "", String lon =""}) async {
    var url = 'http://api.openweathermap.org/data/2.5/weather?q=$query&lat=$lat&lon=$lon&appid=$weatherApiKey&units=metric&lang=ru';
    final response = await Dio().post(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(response.data);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}