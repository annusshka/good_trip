import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_trip/core/data/models/address/i_address.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address extends IAddress with _$Address {
  const factory Address({
    @Default([]) List<double> coordinates,
    @Default('') String country,
    @Default('') String city,
    @Default('') String street,
    @Default('') String house,
  }) = _Address;

  factory Address.fromJson(Map<String, Object?> json) =>
      _$AddressFromJson(json);
}