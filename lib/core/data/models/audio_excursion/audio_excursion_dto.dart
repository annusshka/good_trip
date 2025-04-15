import 'dart:async';

import 'package:good_trip/core/data/models/address/address_dto.dart';
import 'package:good_trip/core/data/models/enum/enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audio_excursion_dto.g.dart';

@JsonSerializable()
class AudioExcursionDto {
  final int? id;
  final String name;
  final String? imagePath;
  final AddressDto address;
  final List<Weekday>? weekdays;
  final String? description;
  final List<String> kinds;
  final bool liked;
  final String? deeplinkUrl;
  final String audioPath;

  AudioExcursionDto({
    this.id,
    required this.name,
    required this.imagePath,
    required this.address,
    required this.weekdays,
    required this.description,
    required this.kinds,
    this.liked = false,
    this.deeplinkUrl,
    required this.audioPath,
  });

  factory AudioExcursionDto.fromJson(Map<String, dynamic> json) =>
      _$AudioExcursionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AudioExcursionDtoToJson(this);
}

FutureOr<Map<String, dynamic>> serializeAudioExcursionDto(AudioExcursionDto object) =>
    object.toJson();
