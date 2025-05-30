// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'excursion_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExcursionDto _$ExcursionDtoFromJson(Map<String, dynamic> json) => ExcursionDto(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      address: AddressDto.fromJson(json['address'] as Map<String, dynamic>),
      weekdays: (json['weekdays'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$WeekdayEnumMap, e))
          .toList(),
      description: json['description'] as String?,
      kinds: (json['kinds'] as List<dynamic>).map((e) => e as String).toList(),
      isLiked: json['isLiked'] as bool? ?? false,
      deeplinkUrl: json['deeplinkUrl'] as String?,
    );

Map<String, dynamic> _$ExcursionDtoToJson(ExcursionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'address': instance.address,
      'weekdays': instance.weekdays?.map((e) => _$WeekdayEnumMap[e]!).toList(),
      'description': instance.description,
      'kinds': instance.kinds,
      'isLiked': instance.isLiked,
      'deeplinkUrl': instance.deeplinkUrl,
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
