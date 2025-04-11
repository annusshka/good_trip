import 'package:good_trip/core/data/models/exception/error_event.dart';

class TourError extends ErrorEvent {
  TourError({
    required super.name,
    super.message,
    super.errorText,
    super.statusCode,
  });
}
