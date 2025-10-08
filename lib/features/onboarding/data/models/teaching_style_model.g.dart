// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teaching_style_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeachingStyleModelImpl _$$TeachingStyleModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TeachingStyleModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$$TeachingStyleModelImplToJson(
        _$TeachingStyleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isSelected': instance.isSelected,
    };
