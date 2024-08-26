import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_trip/core/data/models/models.dart';

part 'address_dto.freezed.dart';
part 'address_dto.g.dart';

@freezed
class AddressDto with _$AddressDto {
  const AddressDto._();

  const factory AddressDto({
    final Point? coordinates,
    final String? country,
    final String? city,
    final String? road,
    final String? street,
    final String? houseNumber,
  }) = _AddressDto;

  factory AddressDto.fromJson(Map<String, Object?> json) =>
      _$AddressDtoFromJson(json);
}
