// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_instructions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaylistInstructionsModelImpl _$$PlaylistInstructionsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PlaylistInstructionsModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      videoClips: (json['videoClips'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      showSkipButton: json['showSkipButton'] as bool,
      buttonText: json['buttonText'] as String,
    );

Map<String, dynamic> _$$PlaylistInstructionsModelImplToJson(
        _$PlaylistInstructionsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'videoClips': instance.videoClips,
      'showSkipButton': instance.showSkipButton,
      'buttonText': instance.buttonText,
    };
