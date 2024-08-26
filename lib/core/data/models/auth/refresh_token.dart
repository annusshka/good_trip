import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token.freezed.dart';
part 'refresh_token.g.dart';

@freezed
class RefreshToken with _$RefreshToken {
  const RefreshToken._();

  const factory RefreshToken({
    required String jwt,
    required String refreshJwt,
  }) = _RefreshToken;

  factory RefreshToken.fromJson(Map<String, Object?> json) =>
      _$RefreshTokenFromJson(json);

}
