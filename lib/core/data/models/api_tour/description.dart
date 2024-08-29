import 'package:freezed_annotation/freezed_annotation.dart';

part 'description.freezed.dart';
part 'description.g.dart';

@freezed
class Description with _$Description {
  const Description._();

  const factory Description({
    final String? descr,
  }) = _Description;

  factory Description.fromJson(Map<String, Object?> json) =>
      _$DescriptionFromJson(json);
}
