// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpeakerImpl _$$SpeakerImplFromJson(Map<String, dynamic> json) =>
    _$SpeakerImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$$SpeakerImplToJson(_$SpeakerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'isSelected': instance.isSelected,
    };
