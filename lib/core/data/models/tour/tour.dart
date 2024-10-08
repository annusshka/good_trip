import 'package:good_trip/core/data/models/address/address.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tour.g.dart';

@JsonSerializable()
class Tour extends ITour {
  Tour({
    required String id,
    required String name,
    String? image,
    required Address address,
    List<Weekday>? weekdays,
    String? description,
    required List<String> kinds,
    bool isLiked = false,
    String? url,
  }) : super(
          id: id,
          name: name,
          image: image,
          address: address,
          weekdays: weekdays,
          description: description,
          kinds: kinds,
          isLiked: isLiked,
          url: url,
        );

  Map<String, dynamic> toJson() => _$TourToJson(this);

  factory Tour.fromJson(Map<String, Object?> json) => _$TourFromJson(json);
}
