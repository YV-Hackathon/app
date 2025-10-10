// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_submission_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnboardingSubmissionRequestImpl _$$OnboardingSubmissionRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$OnboardingSubmissionRequestImpl(
      userId: (json['user_id'] as num).toInt(),
      answers:
          OnboardingAnswers.fromJson(json['answers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OnboardingSubmissionRequestImplToJson(
        _$OnboardingSubmissionRequestImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'answers': instance.answers,
    };

_$OnboardingAnswersImpl _$$OnboardingAnswersImplFromJson(
        Map<String, dynamic> json) =>
    _$OnboardingAnswersImpl(
      speakers: (json['speakers'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      bibleReadingPreference: json['bible_reading_preference'] as String,
      teachingStylePreference: json['teaching_style_preference'] as String,
      genderPreference: json['gender_preference'] as String,
      environmentPreference: json['environment_preference'] as String,
    );

Map<String, dynamic> _$$OnboardingAnswersImplToJson(
        _$OnboardingAnswersImpl instance) =>
    <String, dynamic>{
      'speakers': instance.speakers,
      'bible_reading_preference': instance.bibleReadingPreference,
      'teaching_style_preference': instance.teachingStylePreference,
      'gender_preference': instance.genderPreference,
      'environment_preference': instance.environmentPreference,
    };
