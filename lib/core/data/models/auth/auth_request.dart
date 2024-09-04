import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_request.freezed.dart';
part 'auth_request.g.dart';

@freezed
class AuthRequest with _$AuthRequest {
  const AuthRequest._();

  const factory AuthRequest({
    required String email,
    required String password,
    required String phone,
    required String name,
    required String surname,
  }) = _AuthRequest;

  factory AuthRequest.fromJson(Map<String, Object?> json) =>
      _$AuthRequestFromJson(json);

}
