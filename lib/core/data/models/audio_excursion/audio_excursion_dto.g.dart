// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_excursion_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioExcursionDto _$AudioExcursionDtoFromJson(Map<String, dynamic> json) =>
    AudioExcursionDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imagePath: json['imagePath'] as String?,
      address: AddressDto.fromJson(json['address'] as Map<String, dynamic>),
      weekdays: (json['weekdays'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$WeekdayEnumMap, e))
          .toList(),
      description: json['description'] as String?,
      kinds: (json['kinds'] as List<dynamic>).map((e) => e as String).toList(),
      liked: json['liked'] as bool,
      deeplinkUrl: json['deeplinkUrl'] as String?,
      audioPath: json['audioPath'] as String,
    );

Map<String, dynamic> _$AudioExcursionDtoToJson(AudioExcursionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imagePath': instance.imagePath,
      'address': instance.address,
      'weekdays': instance.weekdays?.map((e) => _$WeekdayEnumMap[e]!).toList(),
      'description': instance.description,
      'kinds': instance.kinds,
      'liked': instance.liked,
      'deeplinkUrl': instance.deeplinkUrl,
      'audioPath': instance.audioPath,
    };

const _$WeekdayEnumMap = {
  Weekday.monday: 'monday',
  Weekday.tuesday: 'tuesday',
  Weekday.wednesday: 'wednesday',
  Weekday.thursday: 'thursday',
  Weekday.friday: 'friday',
  Weekday.saturday: 'saturday',
  Weekday.sunday: 'sunday',
};
