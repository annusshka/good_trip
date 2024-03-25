import 'package:dio/dio.dart';

import '../../data/api/api_key.dart';
import '../models/models.dart';

class WeatherService {

  static Future<LocationInfo> fetchCurrentWeather({query,
    String lat = "", String lon =""}) async {
    var url = 'http://api.openweathermap.org/data/2.5/weather?q=$query'
        '&lat=$lat&lon=$lon&appid=$weatherApiKey&units=metric&lang=ru';
    final response = await Dio().get(url);
    //final response = await Dio().post(url);

    if (response.statusCode == 200) {
      return LocationInfo.fromJson(response.data);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}