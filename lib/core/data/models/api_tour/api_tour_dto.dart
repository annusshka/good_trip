import 'package:freezed_annotation/freezed_annotation.dart';

import 'api_tour_property.dart';

part 'api_tour_dto.g.dart';

@JsonSerializable()
class ApiTourDto {
  final String type;
  final String id;
  final ApiTourProperty properties;

  ApiTourDto({required this.type, required this.id, required this.properties});

  Map<String, dynamic> toJson() => _$ApiTourDtoToJson(this);

  factory ApiTourDto.fromJson(Map<String, Object?> json) =>
      _$ApiTourDtoFromJson(json);
}