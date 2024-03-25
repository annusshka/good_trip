import 'package:flutter/material.dart';

import 'access_level.dart';

class Account {
  String name;
  String surname;
  String email;
  String phone;
  AccessLevel accessLevel;
  Image? image;

  Account({required this.name, required this.surname, required this.email,
    required this.phone, required this.accessLevel, this.image});
}