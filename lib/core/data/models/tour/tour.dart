import 'package:good_trip/core/data/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tour.g.dart';

@JsonSerializable()
class Tour extends ITour {
  Tour({
    required String id,
    required String name,
    String? imageUrl,
    required Address address,
    List<Weekday>? weekdays,
    String? description,
    required List<String> kinds,
    bool isLiked = false,
    String? deeplinkUrl,
    required List<AudioExcursion> excursionList,
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
          excursionList: excursionList,
        );

  Map<String, dynamic> toJson() => _$TourToJson(this);

  factory Tour.fromJson(Map<String, Object?> json) => _$TourFromJson(json);

  @override
  String getWeekdays() {
    return weekdays != null
        ? "${weekdays?.map((el) => el.displayTitle).join(', ')}"
        : 'Любой день';
  }

  @override
  String getKinds() {
    return kinds.join(', ');
  }

  @override
  String getAddressDetails() {
    return (address.street != null ? '${address.street}' : '') +
        (address.house != null ? ', ${address.house}' : '');
  }

  @override
  String getAddressRegion() {
    return '${address.country}, ${address.city}';
  }
}
