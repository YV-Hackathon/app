// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalization_instructions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonalizationInstructionsModelImpl
    _$$PersonalizationInstructionsModelImplFromJson(
            Map<String, dynamic> json) =>
        _$PersonalizationInstructionsModelImpl(
          id: json['id'] as String,
          title: json['title'] as String,
          description: json['description'] as String,
          videoClips: (json['videoClips'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
          showLikeButton: json['showLikeButton'] as bool,
        );

Map<String, dynamic> _$$PersonalizationInstructionsModelImplToJson(
        _$PersonalizationInstructionsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'videoClips': instance.videoClips,
      'showLikeButton': instance.showLikeButton,
    };
