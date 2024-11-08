import 'package:good_trip/core/data/models/address/address_dto.dart';
import 'package:good_trip/core/data/models/enum/enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'excursion_dto.g.dart';

@JsonSerializable()
class ExcursionDto {
  final String id;
  final String name;
  final String? imageUrl;
  final AddressDto address;
  final List<Weekday>? weekdays;
  final String? description;
  final List<String> kinds;
  final bool isLiked;
  final String? deeplinkUrl;

  ExcursionDto({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.address,
    this.weekdays,
    this.description,
    required this.kinds,
    this.isLiked = false,
    this.deeplinkUrl,
  });

  Map<String, dynamic> toJson() => _$ExcursionDtoToJson(this);

  factory ExcursionDto.fromJson(Map<String, Object?> json) =>
      _$ExcursionDtoFromJson(json);
}
