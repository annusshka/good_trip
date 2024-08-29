import 'package:good_trip/core/data/models/exception/error_event.dart';

class WeatherError extends ErrorEvent {
  WeatherError({
    required super.name,
    super.message,
    super.errorText,
  });
}
