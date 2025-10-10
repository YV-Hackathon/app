// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'church_recommendation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChurchRecommendationsResponseImpl
    _$$ChurchRecommendationsResponseImplFromJson(Map<String, dynamic> json) =>
        _$ChurchRecommendationsResponseImpl(
          userId: (json['user_id'] as num).toInt(),
          totalRecommendations: (json['total_recommendations'] as num).toInt(),
          userSummary: UserSummary.fromJson(
              json['user_summary'] as Map<String, dynamic>),
          recommendations: (json['recommendations'] as List<dynamic>)
              .map((e) =>
                  ChurchRecommendation.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$ChurchRecommendationsResponseImplToJson(
        _$ChurchRecommendationsResponseImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'total_recommendations': instance.totalRecommendations,
      'user_summary': instance.userSummary,
      'recommendations': instance.recommendations,
    };

_$UserSummaryImpl _$$UserSummaryImplFromJson(Map<String, dynamic> json) =>
    _$UserSummaryImpl(
      onboardingCompleted: json['onboarding_completed'] as bool,
      sermonRatingsCount: (json['sermon_ratings_count'] as num).toInt(),
      preferences:
          UserPreferences.fromJson(json['preferences'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserSummaryImplToJson(_$UserSummaryImpl instance) =>
    <String, dynamic>{
      'onboarding_completed': instance.onboardingCompleted,
      'sermon_ratings_count': instance.sermonRatingsCount,
      'preferences': instance.preferences,
    };

_$UserPreferencesImpl _$$UserPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$UserPreferencesImpl(
      teachingStyle:
          $enumDecode(_$TeachingStyleEnumMap, json['teaching_style']),
      bibleApproach:
          $enumDecode(_$BibleApproachEnumMap, json['bible_approach']),
      environment: $enumDecode(_$EnvironmentStyleEnumMap, json['environment']),
      genderPreference: $enumDecode(_$GenderEnumMap, json['gender_preference']),
    );

Map<String, dynamic> _$$UserPreferencesImplToJson(
        _$UserPreferencesImpl instance) =>
    <String, dynamic>{
      'teaching_style': _$TeachingStyleEnumMap[instance.teachingStyle]!,
      'bible_approach': _$BibleApproachEnumMap[instance.bibleApproach]!,
      'environment': _$EnvironmentStyleEnumMap[instance.environment]!,
      'gender_preference': _$GenderEnumMap[instance.genderPreference]!,
    };

const _$TeachingStyleEnumMap = {
  TeachingStyle.warmAndConversational: 'WARM_AND_CONVERSATIONAL',
  TeachingStyle.calmAndReflective: 'CALM_AND_REFLECTIVE',
  TeachingStyle.passionateAndHighEnergy: 'PASSIONATE_AND_HIGH_ENERGY',
};

const _$BibleApproachEnumMap = {
  BibleApproach.moreScripture: 'MORE_SCRIPTURE',
  BibleApproach.moreApplication: 'MORE_APPLICATION',
  BibleApproach.balanced: 'BALANCED',
};

const _$EnvironmentStyleEnumMap = {
  EnvironmentStyle.traditional: 'TRADITIONAL',
  EnvironmentStyle.contemporary: 'CONTEMPORARY',
  EnvironmentStyle.blended: 'BLENDED',
};

const _$GenderEnumMap = {
  Gender.male: 'MALE',
  Gender.female: 'FEMALE',
};

_$ChurchRecommendationImpl _$$ChurchRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$ChurchRecommendationImpl(
      churchId: (json['church_id'] as num).toInt(),
      churchName: json['church_name'] as String,
      denomination: json['denomination'] as String,
      description: json['description'] as String?,
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      website: json['website'] as String?,
      imageUrl: json['image_url'] as String?,
      membershipCount: (json['membership_count'] as num?)?.toInt(),
      serviceTimes: json['service_times'] == null
          ? null
          : ServiceTimesModel.fromJson(
              json['service_times'] as Map<String, dynamic>),
      compatibilityScore: (json['compatibility_score'] as num).toDouble(),
      recommendationReasons: (json['recommendation_reasons'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ChurchRecommendationImplToJson(
        _$ChurchRecommendationImpl instance) =>
    <String, dynamic>{
      'church_id': instance.churchId,
      'church_name': instance.churchName,
      'denomination': instance.denomination,
      'description': instance.description,
      'address': instance.address,
      'website': instance.website,
      'image_url': instance.imageUrl,
      'membership_count': instance.membershipCount,
      'service_times': instance.serviceTimes,
      'compatibility_score': instance.compatibilityScore,
      'recommendation_reasons': instance.recommendationReasons,
    };
