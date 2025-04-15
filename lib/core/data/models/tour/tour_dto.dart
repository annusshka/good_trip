import 'package:good_trip/core/data/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tour_dto.g.dart';

@JsonSerializable()
class TourDto {
  final int id;
  final String name;
  final String? imagePath;
  final AddressDto address;
  final List<Weekday>? weekdays;
  final String? description;
  final List<String> kinds;
  final bool liked;
  final String? deeplinkUrl;
  final List<AudioExcursionDto> excursionList;

  TourDto({
    required this.id,
    required this.name,
    this.imagePath,
    required this.address,
    this.weekdays,
    this.description,
    required this.kinds,
    this.liked = false,
    this.deeplinkUrl,
    required this.excursionList,
  });

  Map<String, dynamic> toJson() => _$TourDtoToJson(this);

  factory TourDto.fromJson(Map<String, Object?> json) =>
      _$TourDtoFromJson(json);
}
