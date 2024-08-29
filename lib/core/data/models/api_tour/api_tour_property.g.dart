// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_tour_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiTourProperty _$ApiTourPropertyFromJson(Map<String, dynamic> json) =>
    ApiTourProperty(
      json['address'] == null
          ? null
          : AddressDto.fromJson(json['address'] as Map<String, dynamic>),
      json['point'] == null
          ? null
          : Point.fromJson(json['point'] as Map<String, dynamic>),
      json['image'] as String?,
      json['info'] == null
          ? null
          : Description.fromJson(json['info'] as Map<String, dynamic>),
      xid: json['xid'] as String,
      name: json['name'] as String,
      kinds: json['kinds'] as String,
    );

Map<String, dynamic> _$ApiTourPropertyToJson(ApiTourProperty instance) =>
    <String, dynamic>{
      'xid': instance.xid,
      'name': instance.name,
      'kinds': instance.kinds,
      'address': instance.address,
      'point': instance.point,
      'image': instance.image,
      'info': instance.info,
    };
