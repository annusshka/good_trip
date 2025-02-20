import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_trip/core/data/models/account/access_level.dart';

part 'access_level_dto.freezed.dart';
part 'access_level_dto.g.dart';

@freezed
class AccessLevelDto with _$AccessLevelDto {
  const AccessLevelDto._();

  const factory AccessLevelDto({
    required int id,
    required AccessLevel role,
  }) = _AccessLevelDto;

  factory AccessLevelDto.fromJson(Map<String, Object?> json) =>
      _$AccessLevelDtoFromJson(json);
}
