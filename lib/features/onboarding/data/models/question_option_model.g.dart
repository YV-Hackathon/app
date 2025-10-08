// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionOptionModelImpl _$$QuestionOptionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$QuestionOptionModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$$QuestionOptionModelImplToJson(
        _$QuestionOptionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isSelected': instance.isSelected,
    };
