// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      coordinates: json['coordinates'] == null
          ? null
          : Point.fromJson(json['coordinates'] as Map<String, dynamic>),
      country: json['country'] as String? ?? 'Неизвестно',
      city: json['city'] as String? ?? 'Неизвестно',
      street: json['street'] as String?,
      house: json['house'] as String?,
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates,
      'country': instance.country,
      'city': instance.city,
      'street': instance.street,
      'house': instance.house,
    };
