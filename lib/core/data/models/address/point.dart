import 'package:freezed_annotation/freezed_annotation.dart';

part 'point.freezed.dart';
part 'point.g.dart';

@freezed
class Point with _$Point {
  const Point._();

  const factory Point({
    @Default(51.4) final double lon,
    @Default(39.12) final double lat,
  }) = _Point;

  factory Point.fromJson(Map<String, Object?> json) =>
      _$PointFromJson(json);
}
