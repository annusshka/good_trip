import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_trip/core/data/models/models.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

@freezed
class AuthResponse with _$AuthResponse {
  const AuthResponse._();

  const factory AuthResponse({
    required String token,
    required String refreshToken,
    required UserDto user,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, Object?> json) =>
      _$AuthResponseFromJson(json);

}
