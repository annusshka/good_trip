import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_trip/core/data/models/models.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address extends IAddress with _$Address {
  const factory Address({
    Point? coordinates,
    @Default('Неизвестно') String country,
    @Default('Неизвестно') String city,
    String? street,
    String? house,
  }) = _Address;

  factory Address.fromJson(Map<String, Object?> json) =>
      _$AddressFromJson(json);
}