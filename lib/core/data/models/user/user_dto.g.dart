// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDtoImpl _$$UserDtoImplFromJson(Map<String, dynamic> json) =>
    _$UserDtoImpl(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      role: $enumDecode(_$AccessLevelEnumMap, json['role']),
    );

Map<String, dynamic> _$$UserDtoImplToJson(_$UserDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'surname': instance.surname,
      'phone': instance.phone,
      'password': instance.password,
      'role': _$AccessLevelEnumMap[instance.role]!,
    };

const _$AccessLevelEnumMap = {
  AccessLevel.USER: 'USER',
  AccessLevel.ADMIN: 'ADMIN',
};
