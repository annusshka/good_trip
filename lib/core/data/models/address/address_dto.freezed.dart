// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddressDto _$AddressDtoFromJson(Map<String, dynamic> json) {
  return _AddressDto.fromJson(json);
}

/// @nodoc
mixin _$AddressDto {
  Point? get coordinates => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get road => throw _privateConstructorUsedError;
  String? get street => throw _privateConstructorUsedError;
  String? get houseNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressDtoCopyWith<AddressDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressDtoCopyWith<$Res> {
  factory $AddressDtoCopyWith(
          AddressDto value, $Res Function(AddressDto) then) =
      _$AddressDtoCopyWithImpl<$Res, AddressDto>;
  @useResult
  $Res call(
      {Point? coordinates,
      String? country,
      String? city,
      String? road,
      String? street,
      String? houseNumber});

  $PointCopyWith<$Res>? get coordinates;
}

/// @nodoc
class _$AddressDtoCopyWithImpl<$Res, $Val extends AddressDto>
    implements $AddressDtoCopyWith<$Res> {
  _$AddressDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coordinates = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? road = freezed,
    Object? street = freezed,
    Object? houseNumber = freezed,
  }) {
    return _then(_value.copyWith(
      coordinates: freezed == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as Point?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      road: freezed == road
          ? _value.road
          : road // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      houseNumber: freezed == houseNumber
          ? _value.houseNumber
          : houseNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PointCopyWith<$Res>? get coordinates {
    if (_value.coordinates == null) {
      return null;
    }

    return $PointCopyWith<$Res>(_value.coordinates!, (value) {
      return _then(_value.copyWith(coordinates: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddressDtoImplCopyWith<$Res>
    implements $AddressDtoCopyWith<$Res> {
  factory _$$AddressDtoImplCopyWith(
          _$AddressDtoImpl value, $Res Function(_$AddressDtoImpl) then) =
      __$$AddressDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Point? coordinates,
      String? country,
      String? city,
      String? road,
      String? street,
      String? houseNumber});

  @override
  $PointCopyWith<$Res>? get coordinates;
}

/// @nodoc
class __$$AddressDtoImplCopyWithImpl<$Res>
    extends _$AddressDtoCopyWithImpl<$Res, _$AddressDtoImpl>
    implements _$$AddressDtoImplCopyWith<$Res> {
  __$$AddressDtoImplCopyWithImpl(
      _$AddressDtoImpl _value, $Res Function(_$AddressDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coordinates = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? road = freezed,
    Object? street = freezed,
    Object? houseNumber = freezed,
  }) {
    return _then(_$AddressDtoImpl(
      coordinates: freezed == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as Point?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      road: freezed == road
          ? _value.road
          : road // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      houseNumber: freezed == houseNumber
          ? _value.houseNumber
          : houseNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressDtoImpl extends _AddressDto {
  const _$AddressDtoImpl(
      {this.coordinates,
      this.country,
      this.city,
      this.road,
      this.street,
      this.houseNumber})
      : super._();

  factory _$AddressDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressDtoImplFromJson(json);

  @override
  final Point? coordinates;
  @override
  final String? country;
  @override
  final String? city;
  @override
  final String? road;
  @override
  final String? street;
  @override
  final String? houseNumber;

  @override
  String toString() {
    return 'AddressDto(coordinates: $coordinates, country: $country, city: $city, road: $road, street: $street, houseNumber: $houseNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressDtoImpl &&
            (identical(other.coordinates, coordinates) ||
                other.coordinates == coordinates) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.road, road) || other.road == road) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.houseNumber, houseNumber) ||
                other.houseNumber == houseNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, coordinates, country, city, road, street, houseNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressDtoImplCopyWith<_$AddressDtoImpl> get copyWith =>
      __$$AddressDtoImplCopyWithImpl<_$AddressDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressDtoImplToJson(
      this,
    );
  }
}

abstract class _AddressDto extends AddressDto {
  const factory _AddressDto(
      {final Point? coordinates,
      final String? country,
      final String? city,
      final String? road,
      final String? street,
      final String? houseNumber}) = _$AddressDtoImpl;
  const _AddressDto._() : super._();

  factory _AddressDto.fromJson(Map<String, dynamic> json) =
      _$AddressDtoImpl.fromJson;

  @override
  Point? get coordinates;
  @override
  String? get country;
  @override
  String? get city;
  @override
  String? get road;
  @override
  String? get street;
  @override
  String? get houseNumber;
  @override
  @JsonKey(ignore: true)
  _$$AddressDtoImplCopyWith<_$AddressDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
