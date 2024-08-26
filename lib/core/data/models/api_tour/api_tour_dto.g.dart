// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_tour_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiTourDto _$ApiTourDtoFromJson(Map<String, dynamic> json) => ApiTourDto(
      type: json['type'] as String,
      id: json['id'] as String,
      properties:
          ApiTourProperty.fromJson(json['properties'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiTourDtoToJson(ApiTourDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'properties': instance.properties,
    };
