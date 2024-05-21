// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      role: $enumDecode(_$AccessLevelEnumMap, json['role']),
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'surname': instance.surname,
      'phone': instance.phone,
      'password': instance.password,
      'role': _$AccessLevelEnumMap[instance.role]!,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

const _$AccessLevelEnumMap = {
  AccessLevel.USER: 'USER',
  AccessLevel.ADMIN: 'ADMIN',
};
