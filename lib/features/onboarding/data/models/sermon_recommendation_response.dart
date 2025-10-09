import 'package:freezed_annotation/freezed_annotation.dart';

part 'sermon_recommendation_response.freezed.dart';
part 'sermon_recommendation_response.g.dart';

@freezed
class SermonRecommendationResponse with _$SermonRecommendationResponse {
  const factory SermonRecommendationResponse({
    required List<SermonRecommendation> recommendations,
    @JsonKey(name: 'total_count') required int totalCount,
    @JsonKey(name: 'user_preferences') Map<String, dynamic>? userPreferences,
  }) = _SermonRecommendationResponse;

  factory SermonRecommendationResponse.fromJson(Map<String, dynamic> json) =>
      _$SermonRecommendationResponseFromJson(json);
}

@freezed
class SermonRecommendation with _$SermonRecommendation {
  const factory SermonRecommendation({
    @JsonKey(name: 'sermon_id') required int sermonId,
    required String title,
    required String description,
    @JsonKey(name: 'gcs_url') required String gcsUrl,
    required SermonSpeaker speaker,
    @JsonKey(name: 'matching_preferences')
    required List<String> matchingPreferences,
    @JsonKey(name: 'recommendation_score') required double recommendationScore,
  }) = _SermonRecommendation;

  factory SermonRecommendation.fromJson(Map<String, dynamic> json) =>
      _$SermonRecommendationFromJson(json);
}

@freezed
class SermonSpeaker with _$SermonSpeaker {
  const factory SermonSpeaker({
    required int id,
    required String name,
    required String title,
    @JsonKey(name: 'teaching_style') required String teachingStyle,
    @JsonKey(name: 'bible_approach') required String bibleApproach,
    @JsonKey(name: 'environment_style') required String environmentStyle,
    required String gender,
  }) = _SermonSpeaker;

  factory SermonSpeaker.fromJson(Map<String, dynamic> json) =>
      _$SermonSpeakerFromJson(json);
}
