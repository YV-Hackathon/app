import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_submission_response.freezed.dart';
part 'onboarding_submission_response.g.dart';

@freezed
class OnboardingSubmissionResponse with _$OnboardingSubmissionResponse {
  const factory OnboardingSubmissionResponse({
    String? message,
    @JsonKey(name: 'user_id') int? userId,
    Map<String, dynamic>? user,
    Map<String, dynamic>? data,
    @JsonKey(name: 'recommended_sermons')
    List<RecommendedSermon>? recommendedSermons,
  }) = _OnboardingSubmissionResponse;

  factory OnboardingSubmissionResponse.fromJson(Map<String, dynamic> json) =>
      _$OnboardingSubmissionResponseFromJson(json);
}

@freezed
class RecommendedSermon with _$RecommendedSermon {
  const factory RecommendedSermon({
    required String title,
    required String description,
    @JsonKey(name: 'gcs_url') required String gcsUrl,
    @JsonKey(name: 'is_clip') bool? isClip,
    required int id,
    @JsonKey(name: 'speaker_id') int? speakerId,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    RecommendedSpeaker? speaker,
  }) = _RecommendedSermon;

  factory RecommendedSermon.fromJson(Map<String, dynamic> json) =>
      _$RecommendedSermonFromJson(json);
}

@freezed
class RecommendedSpeaker with _$RecommendedSpeaker {
  const factory RecommendedSpeaker({
    required String name,
    String? title,
    String? bio,
    String? email,
    String? phone,
    @JsonKey(name: 'years_of_service') int? yearsOfService,
    @JsonKey(name: 'social_media') Map<String, dynamic>? socialMedia,
    @JsonKey(name: 'speaking_topics') List<String>? speakingTopics,
    @JsonKey(name: 'sort_order') int? sortOrder,
    @JsonKey(name: 'teaching_style') String? teachingStyle,
    @JsonKey(name: 'bible_approach') String? bibleApproach,
    @JsonKey(name: 'environment_style') String? environmentStyle,
    String? gender,
    @JsonKey(name: 'profile_picture_url') String? profilePictureUrl,
    @JsonKey(name: 'is_recommended') bool? isRecommended,
    required int id,
    @JsonKey(name: 'church_id') int? churchId,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    RecommendedChurch? church,
  }) = _RecommendedSpeaker;

  factory RecommendedSpeaker.fromJson(Map<String, dynamic> json) =>
      _$RecommendedSpeakerFromJson(json);
}

@freezed
class RecommendedChurch with _$RecommendedChurch {
  const factory RecommendedChurch({
    required String name,
    String? denomination,
    String? description,
    Map<String, dynamic>? address,
    String? phone,
    String? email,
    String? website,
    @JsonKey(name: 'founded_year') int? foundedYear,
    @JsonKey(name: 'membership_count') int? membershipCount,
    @JsonKey(name: 'service_times') Map<String, dynamic>? serviceTimes,
    @JsonKey(name: 'social_media') Map<String, dynamic>? socialMedia,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'sort_order') int? sortOrder,
    required int id,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _RecommendedChurch;

  factory RecommendedChurch.fromJson(Map<String, dynamic> json) =>
      _$RecommendedChurchFromJson(json);
}
