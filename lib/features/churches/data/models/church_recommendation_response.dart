import 'package:freezed_annotation/freezed_annotation.dart';
import 'church_model.dart';

part 'church_recommendation_response.freezed.dart';
part 'church_recommendation_response.g.dart';

@freezed
class ChurchRecommendationsResponse with _$ChurchRecommendationsResponse {
  const factory ChurchRecommendationsResponse({
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'total_recommendations') required int totalRecommendations,
    @JsonKey(name: 'user_summary') required UserSummary userSummary,
    required List<ChurchRecommendation> recommendations,
  }) = _ChurchRecommendationsResponse;

  factory ChurchRecommendationsResponse.fromJson(Map<String, dynamic> json) =>
      _$ChurchRecommendationsResponseFromJson(json);
}

@freezed
class UserSummary with _$UserSummary {
  const factory UserSummary({
    @JsonKey(name: 'onboarding_completed') required bool onboardingCompleted,
    @JsonKey(name: 'sermon_ratings_count') required int sermonRatingsCount,
    required UserPreferences preferences,
  }) = _UserSummary;

  factory UserSummary.fromJson(Map<String, dynamic> json) =>
      _$UserSummaryFromJson(json);
}

@freezed
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @JsonKey(name: 'teaching_style') required TeachingStyle teachingStyle,
    @JsonKey(name: 'bible_approach') required BibleApproach bibleApproach,
    required EnvironmentStyle environment,
    @JsonKey(name: 'gender_preference') required Gender genderPreference,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}

@freezed
class ChurchRecommendation with _$ChurchRecommendation {
  const factory ChurchRecommendation({
    @JsonKey(name: 'church_id') required int churchId,
    @JsonKey(name: 'church_name') required String churchName,
    required String denomination,
    String? description,
    AddressModel? address,
    String? website,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'membership_count') int? membershipCount,
    @JsonKey(name: 'service_times') ServiceTimesModel? serviceTimes,
    @JsonKey(name: 'compatibility_score') required double compatibilityScore,
    @JsonKey(name: 'recommendation_reasons')
    @Default([])
    List<String> recommendationReasons,
  }) = _ChurchRecommendation;

  factory ChurchRecommendation.fromJson(Map<String, dynamic> json) =>
      _$ChurchRecommendationFromJson(json);
}

enum TeachingStyle {
  @JsonValue('WARM_AND_CONVERSATIONAL')
  warmAndConversational,
  @JsonValue('CALM_AND_REFLECTIVE')
  calmAndReflective,
  @JsonValue('PASSIONATE_AND_HIGH_ENERGY')
  passionateAndHighEnergy,
}

enum BibleApproach {
  @JsonValue('MORE_SCRIPTURE')
  moreScripture,
  @JsonValue('MORE_APPLICATION')
  moreApplication,
  @JsonValue('BALANCED')
  balanced,
}

enum EnvironmentStyle {
  @JsonValue('TRADITIONAL')
  traditional,
  @JsonValue('CONTEMPORARY')
  contemporary,
  @JsonValue('BLENDED')
  blended,
}

enum Gender {
  @JsonValue('MALE')
  male,
  @JsonValue('FEMALE')
  female,
}
