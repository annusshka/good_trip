// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_tour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioTour _$AudioTourFromJson(Map<String, dynamic> json) => AudioTour(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String?,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      weekdays: (json['weekdays'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$WeekdayEnumMap, e))
          .toList(),
      description: json['description'] as String?,
      kinds: (json['kinds'] as List<dynamic>).map((e) => e as String).toList(),
      isLiked: json['isLiked'] as bool? ?? false,
      url: json['url'] as String?,
      audio: json['audio'] as String,
    );

Map<String, dynamic> _$AudioTourToJson(AudioTour instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'address': instance.address,
      'weekdays': instance.weekdays?.map((e) => _$WeekdayEnumMap[e]!).toList(),
      'description': instance.description,
      'kinds': instance.kinds,
      'isLiked': instance.isLiked,
      'url': instance.url,
      'audio': instance.audio,
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
