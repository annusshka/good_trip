// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorEvent _$ErrorEventFromJson(Map<String, dynamic> json) => ErrorEvent(
      name: json['name'] as String,
      message: json['message'] as String?,
      errorText: json['errorText'] as String?,
    );

Map<String, dynamic> _$ErrorEventToJson(ErrorEvent instance) =>
    <String, dynamic>{
      'name': instance.name,
      'message': instance.message,
      'errorText': instance.errorText,
    };
