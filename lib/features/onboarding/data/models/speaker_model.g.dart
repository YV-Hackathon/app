// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpeakerModelImpl _$$SpeakerModelImplFromJson(Map<String, dynamic> json) =>
    _$SpeakerModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$$SpeakerModelImplToJson(_$SpeakerModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'isSelected': instance.isSelected,
    };
