// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'access_level_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AccessLevelDto _$AccessLevelDtoFromJson(Map<String, dynamic> json) {
  return _AccessLevelDto.fromJson(json);
}

/// @nodoc
mixin _$AccessLevelDto {
  int get id => throw _privateConstructorUsedError;
  AccessLevel get role => throw _privateConstructorUsedError;

  /// Serializes this AccessLevelDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccessLevelDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccessLevelDtoCopyWith<AccessLevelDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccessLevelDtoCopyWith<$Res> {
  factory $AccessLevelDtoCopyWith(
          AccessLevelDto value, $Res Function(AccessLevelDto) then) =
      _$AccessLevelDtoCopyWithImpl<$Res, AccessLevelDto>;
  @useResult
  $Res call({int id, AccessLevel role});
}

/// @nodoc
class _$AccessLevelDtoCopyWithImpl<$Res, $Val extends AccessLevelDto>
    implements $AccessLevelDtoCopyWith<$Res> {
  _$AccessLevelDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccessLevelDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as AccessLevel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccessLevelDtoImplCopyWith<$Res>
    implements $AccessLevelDtoCopyWith<$Res> {
  factory _$$AccessLevelDtoImplCopyWith(_$AccessLevelDtoImpl value,
          $Res Function(_$AccessLevelDtoImpl) then) =
      __$$AccessLevelDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, AccessLevel role});
}

/// @nodoc
class __$$AccessLevelDtoImplCopyWithImpl<$Res>
    extends _$AccessLevelDtoCopyWithImpl<$Res, _$AccessLevelDtoImpl>
    implements _$$AccessLevelDtoImplCopyWith<$Res> {
  __$$AccessLevelDtoImplCopyWithImpl(
      _$AccessLevelDtoImpl _value, $Res Function(_$AccessLevelDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccessLevelDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
  }) {
    return _then(_$AccessLevelDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as AccessLevel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccessLevelDtoImpl extends _AccessLevelDto {
  const _$AccessLevelDtoImpl({required this.id, required this.role})
      : super._();

  factory _$AccessLevelDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccessLevelDtoImplFromJson(json);

  @override
  final int id;
  @override
  final AccessLevel role;

  @override
  String toString() {
    return 'AccessLevelDto(id: $id, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccessLevelDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, role);

  /// Create a copy of AccessLevelDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccessLevelDtoImplCopyWith<_$AccessLevelDtoImpl> get copyWith =>
      __$$AccessLevelDtoImplCopyWithImpl<_$AccessLevelDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccessLevelDtoImplToJson(
      this,
    );
  }
}

abstract class _AccessLevelDto extends AccessLevelDto {
  const factory _AccessLevelDto(
      {required final int id,
      required final AccessLevel role}) = _$AccessLevelDtoImpl;
  const _AccessLevelDto._() : super._();

  factory _AccessLevelDto.fromJson(Map<String, dynamic> json) =
      _$AccessLevelDtoImpl.fromJson;

  @override
  int get id;
  @override
  AccessLevel get role;

  /// Create a copy of AccessLevelDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccessLevelDtoImplCopyWith<_$AccessLevelDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
