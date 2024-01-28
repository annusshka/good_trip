import 'package:flutter/material.dart';
import 'package:good_trip/core/data/models/access_level.dart';

class Account {
  String name;
  String surname;
  AccessLevel accessLevel;
  Image? image;

  Account({required this.name, required this.surname, required this.accessLevel,
    this.image});
}