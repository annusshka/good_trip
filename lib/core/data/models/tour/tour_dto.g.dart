// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourDto _$TourDtoFromJson(Map<String, dynamic> json) => TourDto(
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
      excursionList: (json['excursionList'] as List<dynamic>)
          .map((e) => AudioExcursionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TourDtoToJson(TourDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'address': instance.address,
      'weekdays': instance.weekdays?.map((e) => _$WeekdayEnumMap[e]!).toList(),
      'description': instance.description,
      'kinds': instance.kinds,
      'isLiked': instance.isLiked,
      'deeplinkUrl': instance.deeplinkUrl,
      'excursionList': instance.excursionList,
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
