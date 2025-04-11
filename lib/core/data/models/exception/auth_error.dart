import 'package:good_trip/core/data/models/exception/error_event.dart';

class AuthError extends ErrorEvent {
  AuthError({
    required super.name,
    super.message,
    super.errorText,
    super.statusCode,
  });
}
