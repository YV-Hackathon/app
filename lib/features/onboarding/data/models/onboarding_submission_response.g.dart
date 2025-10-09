// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_submission_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnboardingSubmissionResponseImpl _$$OnboardingSubmissionResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$OnboardingSubmissionResponseImpl(
      message: json['message'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      user: json['user'] as Map<String, dynamic>?,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$OnboardingSubmissionResponseImplToJson(
        _$OnboardingSubmissionResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user_id': instance.userId,
      'user': instance.user,
      'data': instance.data,
    };
