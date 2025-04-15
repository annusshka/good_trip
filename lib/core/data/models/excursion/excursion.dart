import 'package:good_trip/core/data/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'excursion.g.dart';

@JsonSerializable()
class Excursion extends IExcursion {
  Excursion({
    required String id,
    required String name,
    String? imageUrl,
    required Address address,
    List<Weekday>? weekdays,
    String? description,
    required List<TourType> kinds,
    bool isLiked = false,
    String? deeplinkUrl,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          address: address,
          weekdays: weekdays,
          description: description,
          kinds: kinds,
          isLiked: isLiked,
          deeplinkUrl: deeplinkUrl,
        );

  Map<String, dynamic> toJson() => _$ExcursionToJson(this);

  factory Excursion.fromJson(Map<String, Object?> json) => _$ExcursionFromJson(json);
}
