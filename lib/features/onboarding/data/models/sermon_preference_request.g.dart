// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sermon_preference_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SermonPreferenceRequestImpl _$$SermonPreferenceRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SermonPreferenceRequestImpl(
      userId: (json['user_id'] as num).toInt(),
      sermonId: (json['sermon_id'] as num).toInt(),
      preference: json['preference'] as String,
    );

Map<String, dynamic> _$$SermonPreferenceRequestImplToJson(
        _$SermonPreferenceRequestImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'sermon_id': instance.sermonId,
      'preference': instance.preference,
    };
