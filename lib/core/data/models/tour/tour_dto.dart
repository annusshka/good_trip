import 'dart:async';

import 'package:good_trip/core/data/models/address/address_dto.dart';
import 'package:good_trip/core/data/models/enum/enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tour_dto.g.dart';

@JsonSerializable()
class TourDto {
  final String id;
  final String name;
  final String? image;
  final AddressDto address;
  final List<Weekday>? weekdays;
  final String? description;
  final List<String> kinds;
  final bool isLiked;
  final String? url;

  TourDto({
    required this.id,
    required this.name,
    this.image,
    required this.address,
    this.weekdays,
    this.description,
    required this.kinds,
    this.isLiked = false,
    this.url,
  });

  Map<String, dynamic> toJson() => _$TourDtoToJson(this);

  factory TourDto.fromJson(Map<String, Object?> json) =>
      _$TourDtoFromJson(json);
}
