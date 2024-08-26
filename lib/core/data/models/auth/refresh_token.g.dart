// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RefreshTokenImpl _$$RefreshTokenImplFromJson(Map<String, dynamic> json) =>
    _$RefreshTokenImpl(
      jwt: json['jwt'] as String,
      refreshJwt: json['refreshJwt'] as String,
    );

Map<String, dynamic> _$$RefreshTokenImplToJson(_$RefreshTokenImpl instance) =>
    <String, dynamic>{
      'jwt': instance.jwt,
      'refreshJwt': instance.refreshJwt,
    };
