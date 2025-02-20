// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_level_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccessLevelDtoImpl _$$AccessLevelDtoImplFromJson(Map<String, dynamic> json) =>
    _$AccessLevelDtoImpl(
      id: (json['id'] as num).toInt(),
      role: $enumDecode(_$AccessLevelEnumMap, json['role']),
    );

Map<String, dynamic> _$$AccessLevelDtoImplToJson(
        _$AccessLevelDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': _$AccessLevelEnumMap[instance.role]!,
    };

const _$AccessLevelEnumMap = {
  AccessLevel.USER: 'USER',
  AccessLevel.ADMIN: 'ADMIN',
};
