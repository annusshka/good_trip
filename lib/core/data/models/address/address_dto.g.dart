// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressDtoImpl _$$AddressDtoImplFromJson(Map<String, dynamic> json) =>
    _$AddressDtoImpl(
      coordinates: json['coordinates'] == null
          ? null
          : Point.fromJson(json['coordinates'] as Map<String, dynamic>),
      country: json['country'] as String?,
      city: json['city'] as String?,
      road: json['road'] as String?,
      street: json['street'] as String?,
      houseNumber: json['houseNumber'] as String?,
    );

Map<String, dynamic> _$$AddressDtoImplToJson(_$AddressDtoImpl instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates,
      'country': instance.country,
      'city': instance.city,
      'road': instance.road,
      'street': instance.street,
      'houseNumber': instance.houseNumber,
    };
