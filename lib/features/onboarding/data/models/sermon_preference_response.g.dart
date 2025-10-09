// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sermon_preference_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SermonPreferenceResponseImpl _$$SermonPreferenceResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SermonPreferenceResponseImpl(
      message: json['message'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      sermonId: (json['sermon_id'] as num?)?.toInt(),
      preference: json['preference'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$SermonPreferenceResponseImplToJson(
        _$SermonPreferenceResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user_id': instance.userId,
      'sermon_id': instance.sermonId,
      'preference': instance.preference,
      'data': instance.data,
    };
