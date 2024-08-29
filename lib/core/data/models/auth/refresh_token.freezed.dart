// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refresh_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RefreshToken _$RefreshTokenFromJson(Map<String, dynamic> json) {
  return _RefreshToken.fromJson(json);
}

/// @nodoc
mixin _$RefreshToken {
  String get jwt => throw _privateConstructorUsedError;
  String get refreshJwt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RefreshTokenCopyWith<RefreshToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefreshTokenCopyWith<$Res> {
  factory $RefreshTokenCopyWith(
          RefreshToken value, $Res Function(RefreshToken) then) =
      _$RefreshTokenCopyWithImpl<$Res, RefreshToken>;
  @useResult
  $Res call({String jwt, String refreshJwt});
}

/// @nodoc
class _$RefreshTokenCopyWithImpl<$Res, $Val extends RefreshToken>
    implements $RefreshTokenCopyWith<$Res> {
  _$RefreshTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jwt = null,
    Object? refreshJwt = null,
  }) {
    return _then(_value.copyWith(
      jwt: null == jwt
          ? _value.jwt
          : jwt // ignore: cast_nullable_to_non_nullable
              as String,
      refreshJwt: null == refreshJwt
          ? _value.refreshJwt
          : refreshJwt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RefreshTokenImplCopyWith<$Res>
    implements $RefreshTokenCopyWith<$Res> {
  factory _$$RefreshTokenImplCopyWith(
          _$RefreshTokenImpl value, $Res Function(_$RefreshTokenImpl) then) =
      __$$RefreshTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String jwt, String refreshJwt});
}

/// @nodoc
class __$$RefreshTokenImplCopyWithImpl<$Res>
    extends _$RefreshTokenCopyWithImpl<$Res, _$RefreshTokenImpl>
    implements _$$RefreshTokenImplCopyWith<$Res> {
  __$$RefreshTokenImplCopyWithImpl(
      _$RefreshTokenImpl _value, $Res Function(_$RefreshTokenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jwt = null,
    Object? refreshJwt = null,
  }) {
    return _then(_$RefreshTokenImpl(
      jwt: null == jwt
          ? _value.jwt
          : jwt // ignore: cast_nullable_to_non_nullable
              as String,
      refreshJwt: null == refreshJwt
          ? _value.refreshJwt
          : refreshJwt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RefreshTokenImpl extends _RefreshToken {
  const _$RefreshTokenImpl({required this.jwt, required this.refreshJwt})
      : super._();

  factory _$RefreshTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$RefreshTokenImplFromJson(json);

  @override
  final String jwt;
  @override
  final String refreshJwt;

  @override
  String toString() {
    return 'RefreshToken(jwt: $jwt, refreshJwt: $refreshJwt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshTokenImpl &&
            (identical(other.jwt, jwt) || other.jwt == jwt) &&
            (identical(other.refreshJwt, refreshJwt) ||
                other.refreshJwt == refreshJwt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, jwt, refreshJwt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshTokenImplCopyWith<_$RefreshTokenImpl> get copyWith =>
      __$$RefreshTokenImplCopyWithImpl<_$RefreshTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RefreshTokenImplToJson(
      this,
    );
  }
}

abstract class _RefreshToken extends RefreshToken {
  const factory _RefreshToken(
      {required final String jwt,
      required final String refreshJwt}) = _$RefreshTokenImpl;
  const _RefreshToken._() : super._();

  factory _RefreshToken.fromJson(Map<String, dynamic> json) =
      _$RefreshTokenImpl.fromJson;

  @override
  String get jwt;
  @override
  String get refreshJwt;
  @override
  @JsonKey(ignore: true)
  _$$RefreshTokenImplCopyWith<_$RefreshTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
