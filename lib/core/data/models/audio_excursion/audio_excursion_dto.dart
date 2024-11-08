import 'dart:async';

import 'package:good_trip/core/data/models/address/address_dto.dart';
import 'package:good_trip/core/data/models/enum/enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audio_excursion_dto.g.dart';

@JsonSerializable()
class AudioExcursionDto {
  final String id;
  final String name;
  final String? imageUrl;
  final AddressDto address;
  final List<Weekday>? weekdays;
  final String? description;
  final List<String> kinds;
  final bool isLiked;
  final String? deeplinkUrl;
  final String audioUrl;

  AudioExcursionDto({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.weekdays,
    required this.description,
    required this.kinds,
    required this.isLiked,
    required this.deeplinkUrl,
    required this.audioUrl,
  });

  factory AudioExcursionDto.fromJson(Map<String, dynamic> json) =>
      _$AudioExcursionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AudioExcursionDtoToJson(this);
}

FutureOr<Map<String, dynamic>> serializeAudioExcursionDto(AudioExcursionDto object) =>
    object.toJson();
