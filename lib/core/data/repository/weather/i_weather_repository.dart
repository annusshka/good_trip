import 'package:good_trip/core/data/models/models.dart';

abstract class IWeatherRepository {
  Future<LocationInfo> fetchCurrentWeather({String? query,
    double lat = 55.7522, double lon = 37.6156 });
}