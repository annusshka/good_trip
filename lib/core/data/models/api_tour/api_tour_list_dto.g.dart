// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_tour_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiTourListDto _$ApiTourListDtoFromJson(Map<String, dynamic> json) =>
    ApiTourListDto(
      type: json['type'] as String,
      features: (json['features'] as List<dynamic>)
          .map((e) => ApiTourDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApiTourListDtoToJson(ApiTourListDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'features': instance.features,
    };
