import 'package:freezed_annotation/freezed_annotation.dart';
import 'church_model.dart';
import '../../domain/entities/church_detail.dart';

part 'featured_sermons_response.freezed.dart';
part 'featured_sermons_response.g.dart';

// The API returns a list directly, so we'll use this as the main response type
typedef FeaturedSermonsResponse = List<FeaturedSermonItem>;

@freezed
class FeaturedSermonItem with _$FeaturedSermonItem {
  const factory FeaturedSermonItem({
    @JsonKey(name: 'church_id') required int churchId,
    @JsonKey(name: 'sermon_id') required int sermonId,
    @JsonKey(name: 'sort_order') required int sortOrder,
    @JsonKey(name: 'is_active') required bool isActive,
    required int id,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    required FeaturedSermonChurch church,
    required FeaturedSermonData sermon,
  }) = _FeaturedSermonItem;

  factory FeaturedSermonItem.fromJson(Map<String, dynamic> json) =>
      _$FeaturedSermonItemFromJson(json);
}

@freezed
class FeaturedSermonChurch with _$FeaturedSermonChurch {
  const factory FeaturedSermonChurch({
    required String name,
    required String denomination,
    String? description,
    AddressModel? address,
    String? phone,
    String? email,
    String? website,
    @JsonKey(name: 'founded_year') int? foundedYear,
    @JsonKey(name: 'membership_count') int? membershipCount,
    @JsonKey(name: 'service_times') ServiceTimesModel? serviceTimes,
    @JsonKey(name: 'social_media') SocialMediaModel? socialMedia,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'sort_order') required int sortOrder,
    required int id,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _FeaturedSermonChurch;

  factory FeaturedSermonChurch.fromJson(Map<String, dynamic> json) =>
      _$FeaturedSermonChurchFromJson(json);
}

@freezed
class FeaturedSermonData with _$FeaturedSermonData {
  const factory FeaturedSermonData({
    required String title,
    String? description,
    @JsonKey(name: 'gcs_url') required String gcsUrl,
    @JsonKey(name: 'is_clip') required bool isClip,
    required int id,
    @JsonKey(name: 'speaker_id') required int speakerId,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    required FeaturedSermonSpeaker speaker,
  }) = _FeaturedSermonData;

  factory FeaturedSermonData.fromJson(Map<String, dynamic> json) =>
      _$FeaturedSermonDataFromJson(json);
}

@freezed
class FeaturedSermonSpeaker with _$FeaturedSermonSpeaker {
  const factory FeaturedSermonSpeaker({
    required String name,
    String? title,
    String? bio,
    String? email,
    String? phone,
    @JsonKey(name: 'years_of_service') int? yearsOfService,
    @JsonKey(name: 'social_media') SpeakerSocialMediaModel? socialMedia,
    @JsonKey(name: 'speaking_topics')
    @Default([])
    List<SpeakingTopicModel> speakingTopics,
    @JsonKey(name: 'sort_order') required int sortOrder,
    @JsonKey(name: 'teaching_style')
    @TeachingStyleConverter()
    required TeachingStyle teachingStyle,
    @JsonKey(name: 'bible_approach')
    @BibleApproachConverter()
    required BibleApproach bibleApproach,
    @JsonKey(name: 'environment_style')
    @EnvironmentStyleConverter()
    required EnvironmentStyle environmentStyle,
    @GenderConverter() required Gender gender,
    @JsonKey(name: 'profile_picture_url') String? profilePictureUrl,
    @JsonKey(name: 'is_recommended') required bool isRecommended,
    required int id,
    @JsonKey(name: 'church_id') required int churchId,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _FeaturedSermonSpeaker;

  factory FeaturedSermonSpeaker.fromJson(Map<String, dynamic> json) =>
      _$FeaturedSermonSpeakerFromJson(json);
}
