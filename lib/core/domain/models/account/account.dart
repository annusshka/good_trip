import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'access_level.dart';

part 'account.freezed.dart';

part 'account.g.dart';

@freezed
class Account with _$Account {
  const Account._();

  const factory Account({
    required String login,
    required String password,
    required AccessLevel accessLevel,
  }) = _Account;

  factory Account.fromJson(Map<String, Object?> json) =>
      _$AccountFromJson(json);
}

/*class Account {
  String name;
  String surname;
  String email;
  String phone;
  AccessLevel accessLevel;
  Image? image;

  Account({required this.name, required this.surname, required this.email,
    required this.phone, required this.accessLevel, this.image});
}*/