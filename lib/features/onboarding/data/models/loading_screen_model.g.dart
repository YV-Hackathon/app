// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loading_screen_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoadingScreenModelImpl _$$LoadingScreenModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LoadingScreenModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      buttonText: json['buttonText'] as String,
      progressSteps: (json['progressSteps'] as num).toInt(),
      currentStep: (json['currentStep'] as num).toInt(),
    );

Map<String, dynamic> _$$LoadingScreenModelImplToJson(
        _$LoadingScreenModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'buttonText': instance.buttonText,
      'progressSteps': instance.progressSteps,
      'currentStep': instance.currentStep,
    };
