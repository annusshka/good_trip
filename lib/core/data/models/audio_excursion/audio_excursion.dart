import 'package:good_trip/core/data/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audio_excursion.g.dart';

@JsonSerializable()
class AudioExcursion implements IAudioExcursion {
  AudioExcursion({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.address,
    this.weekdays,
    this.description,
    required this.kinds,
    this.isLiked = false,
    this.deeplinkUrl,
    required this.audioUrl,
  });

  @override
  final String id;
  @override
  final String name;
  @override
  final String? imageUrl;
  @override
  final Address address;
  @override
  final List<Weekday>? weekdays;
  @override
  final String? description;
  @override
  final List<TourType> kinds;
  @override
  bool isLiked;
  @override
  final String? deeplinkUrl;
  @override
  final String audioUrl;

  Map<String, dynamic> toJson() => _$AudioExcursionToJson(this);

  factory AudioExcursion.fromJson(Map<String, Object?> json) => _$AudioExcursionFromJson(json);

  @override
  String getWeekdays() {
    return weekdays != null ? "${weekdays?.map((el) => el.displayTitle).join(', ')}" : 'Любой день';
  }

  @override
  String getKinds() {
    List<String> tourTypes = [];
    for (final TourType type in kinds) {
      tourTypes.add(type.displayText);
    }
    return tourTypes.join(', ');
  }

  @override
  String getAddressDetails() {
    final street = address.street ?? '';
    final house = address.house ?? '';
    if (street.isEmpty && house.isEmpty) return '${address.country}, ${address.city}';
    if (street.isEmpty && house.isNotEmpty) return house;
    if (street.isNotEmpty && house.isEmpty) return street;
    return '$street, $house';
  }

  @override
  String getAddressRegion() {
    if ((address.street ?? '').isEmpty && (address.house ?? '').isEmpty) return '';
    return '${address.country}, ${address.city}';
  }
}
