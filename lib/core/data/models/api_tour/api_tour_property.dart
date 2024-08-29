import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_trip/core/data/models/models.dart';

part 'api_tour_property.g.dart';

@JsonSerializable()
class ApiTourProperty {
  final String xid;
  final String name;
  final String kinds;
  final AddressDto? address;
  final Point? point;
  final String? image;
  final Description? info;

  ApiTourProperty(
    this.address,
    this.point,
    this.image,
    this.info, {
    required this.xid,
    required this.name,
    required this.kinds,
  });

  Map<String, dynamic> toJson() => _$ApiTourPropertyToJson(this);

  factory ApiTourProperty.fromJson(Map<String, Object?> json) =>
      _$ApiTourPropertyFromJson(json);
}
