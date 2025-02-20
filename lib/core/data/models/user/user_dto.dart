import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_trip/core/data/models/account/access_level.dart';
import 'package:good_trip/core/data/models/user/access_level_dto.dart';

part 'user_dto.freezed.dart';

part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const UserDto._();

  const factory UserDto({
    required int id,
    required String email,
    required String name,
    required String surname,
    required String phone,
    required String password,
    required List<AccessLevelDto> roles,
  }) = _UserDto;

  factory UserDto.account({
    required int id,
    required String name,
    required String surname,
    required String email,
    required String phone,
  }) {
    return UserDto.account(
      id: id,
      email: email,
      name: name,
      surname: surname,
      phone: phone,
    );
  }

  factory UserDto.fromJson(Map<String, Object?> json) =>
      _$UserDtoFromJson(json);
}
