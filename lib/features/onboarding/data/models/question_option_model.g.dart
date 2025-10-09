// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionOptionModelImpl _$$QuestionOptionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$QuestionOptionModelImpl(
      value: json['value'] as String,
      label: json['label'] as String,
      subtitle: json['subtitle'] as String?,
      church: json['church'] as String?,
      profilePictureUrl: json['profile_picture_url'] as String?,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$$QuestionOptionModelImplToJson(
        _$QuestionOptionModelImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'subtitle': instance.subtitle,
      'church': instance.church,
      'profile_picture_url': instance.profilePictureUrl,
      'isSelected': instance.isSelected,
    };
