import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_trip/core/data/models/models.dart';

part 'address_dto.freezed.dart';
part 'address_dto.g.dart';

@freezed
class AddressDto with _$AddressDto {
  const AddressDto._();

  const factory AddressDto({
    final double? lat,
    final double? lon,
    final String? country,
    final String? city,
    final String? road,
    final String? street,
    final String? house,
  }) = _AddressDto;

  factory AddressDto.fromJson(Map<String, Object?> json) =>
      _$AddressDtoFromJson(json);
}
