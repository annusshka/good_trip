import 'package:good_trip/core/data/models/exception/error.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_event.g.dart';

@JsonSerializable()
class ErrorEvent extends IError {
  ErrorEvent({
    required super.name,
    this.message,
    this.errorText,
  });

  final String? message;
  final String? errorText;
}
