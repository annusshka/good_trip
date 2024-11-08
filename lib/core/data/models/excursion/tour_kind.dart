import 'package:json_annotation/json_annotation.dart';

part 'tour_kind.g.dart';

@JsonSerializable()
class TourKind {
  final String name;
  final String translation;

  TourKind({
    required this.name,
    required this.translation,
  });

  Map<String, dynamic> toJson() => _$TourKindToJson(this);

  factory TourKind.fromJson(Map<String, Object?> json) =>
      _$TourKindFromJson(json);
}
