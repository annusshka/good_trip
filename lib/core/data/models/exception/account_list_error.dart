import 'package:good_trip/core/data/models/exception/error_event.dart';

class AccountListError extends ErrorEvent {
  AccountListError({
    required super.name,
    super.message,
    super.errorText,
  });
}
