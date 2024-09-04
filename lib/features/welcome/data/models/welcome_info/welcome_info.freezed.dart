// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'welcome_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WelcomeInfo _$WelcomeInfoFromJson(Map<String, dynamic> json) {
  return _WelcomeInfo.fromJson(json);
}

/// @nodoc
mixin _$WelcomeInfo {
  String get text => throw _privateConstructorUsedError;
  String get subtext => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WelcomeInfoCopyWith<WelcomeInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WelcomeInfoCopyWith<$Res> {
  factory $WelcomeInfoCopyWith(
          WelcomeInfo value, $Res Function(WelcomeInfo) then) =
      _$WelcomeInfoCopyWithImpl<$Res, WelcomeInfo>;
  @useResult
  $Res call({String text, String subtext, String image});
}

/// @nodoc
class _$WelcomeInfoCopyWithImpl<$Res, $Val extends WelcomeInfo>
    implements $WelcomeInfoCopyWith<$Res> {
  _$WelcomeInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? subtext = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      subtext: null == subtext
          ? _value.subtext
          : subtext // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WelcomeInfoImplCopyWith<$Res>
    implements $WelcomeInfoCopyWith<$Res> {
  factory _$$WelcomeInfoImplCopyWith(
          _$WelcomeInfoImpl value, $Res Function(_$WelcomeInfoImpl) then) =
      __$$WelcomeInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String subtext, String image});
}

/// @nodoc
class __$$WelcomeInfoImplCopyWithImpl<$Res>
    extends _$WelcomeInfoCopyWithImpl<$Res, _$WelcomeInfoImpl>
    implements _$$WelcomeInfoImplCopyWith<$Res> {
  __$$WelcomeInfoImplCopyWithImpl(
      _$WelcomeInfoImpl _value, $Res Function(_$WelcomeInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? subtext = null,
    Object? image = null,
  }) {
    return _then(_$WelcomeInfoImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      subtext: null == subtext
          ? _value.subtext
          : subtext // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WelcomeInfoImpl extends _WelcomeInfo {
  const _$WelcomeInfoImpl(
      {required this.text, required this.subtext, required this.image})
      : super._();

  factory _$WelcomeInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$WelcomeInfoImplFromJson(json);

  @override
  final String text;
  @override
  final String subtext;
  @override
  final String image;

  @override
  String toString() {
    return 'WelcomeInfo(text: $text, subtext: $subtext, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WelcomeInfoImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.subtext, subtext) || other.subtext == subtext) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text, subtext, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WelcomeInfoImplCopyWith<_$WelcomeInfoImpl> get copyWith =>
      __$$WelcomeInfoImplCopyWithImpl<_$WelcomeInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WelcomeInfoImplToJson(
      this,
    );
  }
}

abstract class _WelcomeInfo extends WelcomeInfo {
  const factory _WelcomeInfo(
      {required final String text,
      required final String subtext,
      required final String image}) = _$WelcomeInfoImpl;
  const _WelcomeInfo._() : super._();

  factory _WelcomeInfo.fromJson(Map<String, dynamic> json) =
      _$WelcomeInfoImpl.fromJson;

  @override
  String get text;
  @override
  String get subtext;
  @override
  String get image;
  @override
  @JsonKey(ignore: true)
  _$$WelcomeInfoImplCopyWith<_$WelcomeInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
