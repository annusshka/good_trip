import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_trip/core/data/models/account/access_level.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    required int id,
    required String email,
    required String name,
    required String surname,
    required String phone,
    required String password,
    required AccessLevel role,
  }) = _User;

  factory User.account({
    required int id,
    required String name,
    required String surname,
    required String email,
    required String phone
  }) {
    return User.account(id: id, email: email, name: name, surname: surname, phone: phone,);
  }

  factory User.fromJson(Map<String, Object?> json) =>
      _$UserFromJson(json);
}

// class User {
//   String id;
//   String email;
//   String name;
//   String surname;
//   String phone;
//   String password;
//   AccessLevel role = AccessLevel.user;
//   String? accessToken;
//   String? refreshToken;
//
//   User({
//     required this.id,
//     required this.email,
//     required this.name,
//     required this.surname,
//     required this.phone,
//     required this.password,
//     required this.role,
//     required this.accessToken,
//     required this.refreshToken,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     final user = User(
//       id: json['id'],
//       email: json['email'],
//       name: json['name'],
//       surname: json['surname'],
//       phone: json['phone'],
//       password: json['password'],
//       role: json['role'],
//       accessToken: json['accessToken'],
//       refreshToken: json['refreshToken'],
//     );
//     return user;
//   }
//
//   String fullName() {
//     return '$name $surname';
//   }
// }
