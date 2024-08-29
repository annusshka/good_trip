import 'dart:async';

import 'package:good_trip/core/data/models/address/address_dto.dart';
import 'package:good_trip/core/data/models/enum/enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audio_tour_dto.g.dart';

@JsonSerializable()
class AudioTourDto {
  final String id;
  final String name;
  final String? image;
  final AddressDto address;
  final List<Weekday>? weekdays;
  final String? description;
  final List<String> kinds;
  final bool isLiked;
  final String? url;
  final String audio;

  AudioTourDto({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
    required this.weekdays,
    required this.description,
    required this.kinds,
    required this.isLiked,
    required this.url,
    required this.audio,
  });

  factory AudioTourDto.fromJson(Map<String, dynamic> json) =>
      _$AudioTourDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AudioTourDtoToJson(this);
}

FutureOr<Map<String, dynamic>> serializeAudioTourDto(AudioTourDto object) =>
    object.toJson();
