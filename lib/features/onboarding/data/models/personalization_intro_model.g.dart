// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalization_intro_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonalizationIntroModelImpl _$$PersonalizationIntroModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PersonalizationIntroModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      videoClips: (json['videoClips'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$PersonalizationIntroModelImplToJson(
        _$PersonalizationIntroModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'videoClips': instance.videoClips,
    };
