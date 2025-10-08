// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'church_environment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChurchEnvironmentModelImpl _$$ChurchEnvironmentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChurchEnvironmentModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$$ChurchEnvironmentModelImplToJson(
        _$ChurchEnvironmentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isSelected': instance.isSelected,
    };
