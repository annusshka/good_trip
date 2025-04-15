// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'excursion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Excursion _$ExcursionFromJson(Map<String, dynamic> json) => Excursion(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      weekdays: (json['weekdays'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$WeekdayEnumMap, e))
          .toList(),
      description: json['description'] as String?,
      kinds: (json['kinds'] as List<dynamic>)
          .map((e) => $enumDecode(_$TourTypeEnumMap, e))
          .toList(),
      isLiked: json['isLiked'] as bool? ?? false,
      deeplinkUrl: json['deeplinkUrl'] as String?,
    );

Map<String, dynamic> _$ExcursionToJson(Excursion instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'address': instance.address,
      'weekdays': instance.weekdays?.map((e) => _$WeekdayEnumMap[e]!).toList(),
      'description': instance.description,
      'kinds': instance.kinds.map((e) => _$TourTypeEnumMap[e]!).toList(),
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

const _$TourTypeEnumMap = {
  TourType.accomodations: 'accomodations',
  TourType.adult: 'adult',
  TourType.amusements: 'amusements',
  TourType.interesting_places: 'interesting_places',
  TourType.cultural: 'cultural',
  TourType.architecture: 'architecture',
  TourType.museums: 'museums',
  TourType.theatres_and_entertainments: 'theatres_and_entertainments',
  TourType.archaeology: 'archaeology',
  TourType.burial_places: 'burial_places',
  TourType.monuments_and_memorials: 'monuments_and_memorials',
  TourType.natural: 'natural',
  TourType.beaches: 'beaches',
  TourType.geological_formations: 'geological_formations',
  TourType.islands: 'islands',
  TourType.natural_springs: 'natural_springs',
  TourType.nature_reserves: 'nature_reserves',
  TourType.water: 'water',
  TourType.religion: 'religion',
  TourType.sport: 'sport',
  TourType.climbing: 'climbing',
  TourType.diving: 'diving',
  TourType.winter_sports: 'winter_sports',
  TourType.banks: 'banks',
  TourType.foods: 'foods',
  TourType.shops: 'shops',
  TourType.transport: 'transport',
  TourType.historic: 'historic',
};
