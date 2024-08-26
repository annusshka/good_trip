import 'package:freezed_annotation/freezed_annotation.dart';

import 'api_tour_dto.dart';

part 'api_tour_list_dto.g.dart';

@JsonSerializable()
class ApiTourListDto {
  final String type;
  final List<ApiTourDto> features;

  ApiTourListDto({required this.type, required this.features});

  Map<String, dynamic> toJson() => _$ApiTourListDtoToJson(this);

  factory ApiTourListDto.fromJson(Map<String, Object?> json) =>
      _$ApiTourListDtoFromJson(json);
}