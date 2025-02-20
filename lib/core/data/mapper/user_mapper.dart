import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/models/user/access_level_dto.dart';

User mapDtoToUser(UserDto dto) {
  return User(
    id: dto.id,
    name: dto.name,
    email: dto.email,
    surname: dto.surname,
    phone: dto.phone,
    password: dto.password,
    role: mapDtoToAccessLevel(dto.roles),
  );
}

AccessLevel mapDtoToAccessLevel(List<AccessLevelDto> dto) {
  if (dto.isNotEmpty) {
    switch (dto[0].id) {
      case 1:
        return AccessLevel.USER;
      case 2:
        return AccessLevel.ADMIN;
      default:
        return AccessLevel.USER;
    }
  } else {
    return AccessLevel.USER;
  }
}

UserDto mapUserToDto(User user) {
  return UserDto(
    id: user.id,
    name: user.name,
    email: user.email,
    surname: user.surname,
    phone: user.phone,
    password: user.password,
    roles: [
      AccessLevelDto(
        id: 1,
        role: user.role,
      ),
    ],
  );
}

List<UserDto> mapUserListToDto(
  List<User> users,
) {
  return users.map(mapUserToDto).toList();
}

List<User> mapDtoToUserList(
  List<UserDto> users,
) {
  return users.map(mapDtoToUser).toList();
}
