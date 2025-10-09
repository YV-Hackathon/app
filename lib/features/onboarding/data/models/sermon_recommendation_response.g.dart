// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sermon_recommendation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SermonRecommendationResponseImpl _$$SermonRecommendationResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SermonRecommendationResponseImpl(
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => SermonRecommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['total_count'] as num).toInt(),
      userPreferences: json['user_preferences'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$SermonRecommendationResponseImplToJson(
        _$SermonRecommendationResponseImpl instance) =>
    <String, dynamic>{
      'recommendations': instance.recommendations,
      'total_count': instance.totalCount,
      'user_preferences': instance.userPreferences,
    };

_$SermonRecommendationImpl _$$SermonRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$SermonRecommendationImpl(
      sermonId: (json['sermon_id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      gcsUrl: json['gcs_url'] as String,
      speaker: SermonSpeaker.fromJson(json['speaker'] as Map<String, dynamic>),
      matchingPreferences: (json['matching_preferences'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      recommendationScore: (json['recommendation_score'] as num).toDouble(),
    );

Map<String, dynamic> _$$SermonRecommendationImplToJson(
        _$SermonRecommendationImpl instance) =>
    <String, dynamic>{
      'sermon_id': instance.sermonId,
      'title': instance.title,
      'description': instance.description,
      'gcs_url': instance.gcsUrl,
      'speaker': instance.speaker,
      'matching_preferences': instance.matchingPreferences,
      'recommendation_score': instance.recommendationScore,
    };

_$SermonSpeakerImpl _$$SermonSpeakerImplFromJson(Map<String, dynamic> json) =>
    _$SermonSpeakerImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      title: json['title'] as String,
      teachingStyle: json['teaching_style'] as String,
      bibleApproach: json['bible_approach'] as String,
      environmentStyle: json['environment_style'] as String,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$$SermonSpeakerImplToJson(_$SermonSpeakerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'teaching_style': instance.teachingStyle,
      'bible_approach': instance.bibleApproach,
      'environment_style': instance.environmentStyle,
      'gender': instance.gender,
    };
