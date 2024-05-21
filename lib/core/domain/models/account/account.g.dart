// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountImpl _$$AccountImplFromJson(Map<String, dynamic> json) =>
    _$AccountImpl(
      login: json['login'] as String,
      password: json['password'] as String,
      accessLevel: $enumDecode(_$AccessLevelEnumMap, json['accessLevel']),
    );

Map<String, dynamic> _$$AccountImplToJson(_$AccountImpl instance) =>
    <String, dynamic>{
      'login': instance.login,
      'password': instance.password,
      'accessLevel': _$AccessLevelEnumMap[instance.accessLevel]!,
    };

const _$AccessLevelEnumMap = {
  AccessLevel.USER: 'USER',
  AccessLevel.ADMIN: 'ADMIN',
};
