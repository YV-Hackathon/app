import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/church_detail.dart';

part 'church_model.freezed.dart';
part 'church_model.g.dart';

@freezed
class ChurchModel with _$ChurchModel {
  const factory ChurchModel({
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
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @Default([]) List<SpeakerModel> speakers,
    required int id,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _ChurchModel;

  factory ChurchModel.fromJson(Map<String, dynamic> json) =>
      _$ChurchModelFromJson(json);
}

@freezed
class AddressModel with _$AddressModel {
  const factory AddressModel({
    String? street,
    String? city,
    String? state,
    @JsonKey(name: 'zip_code') String? zipCode,
    String? country,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}

@freezed
class ServiceTimesModel with _$ServiceTimesModel {
  const factory ServiceTimesModel({
    List<String>? sunday,
    List<String>? monday,
    List<String>? tuesday,
    List<String>? wednesday,
    List<String>? thursday,
    List<String>? friday,
    List<String>? saturday,
    List<String>? weekdays,
  }) = _ServiceTimesModel;

  factory ServiceTimesModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceTimesModelFromJson(json);
}

@freezed
class SocialMediaModel with _$SocialMediaModel {
  const factory SocialMediaModel({
    String? facebook,
    String? instagram,
    String? twitter,
    String? youtube,
    String? linkedin,
  }) = _SocialMediaModel;

  factory SocialMediaModel.fromJson(Map<String, dynamic> json) =>
      _$SocialMediaModelFromJson(json);
}

@freezed
class SpeakerModel with _$SpeakerModel {
  const factory SpeakerModel({
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
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'teaching_style')
    @Default(TeachingStyle.warmAndConversational)
    TeachingStyle teachingStyle,
    @JsonKey(name: 'bible_approach')
    @Default(BibleApproach.balanced)
    BibleApproach bibleApproach,
    @JsonKey(name: 'environment_style')
    @Default(EnvironmentStyle.blended)
    EnvironmentStyle environmentStyle,
    Gender? gender,
    @JsonKey(name: 'profile_picture_url') String? profilePictureUrl,
    @JsonKey(name: 'is_recommended') @Default(false) bool isRecommended,
    required int id,
    @JsonKey(name: 'church_id') int? churchId,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _SpeakerModel;

  factory SpeakerModel.fromJson(Map<String, dynamic> json) =>
      _$SpeakerModelFromJson(json);
}

@freezed
class SpeakerSocialMediaModel with _$SpeakerSocialMediaModel {
  const factory SpeakerSocialMediaModel({
    String? facebook,
    String? instagram,
    String? twitter,
    String? youtube,
    String? linkedin,
  }) = _SpeakerSocialMediaModel;

  factory SpeakerSocialMediaModel.fromJson(Map<String, dynamic> json) =>
      _$SpeakerSocialMediaModelFromJson(json);
}

@freezed
class SpeakingTopicModel with _$SpeakingTopicModel {
  const factory SpeakingTopicModel({
    required String name,
    String? description,
    required SpeakingTopicCategory category,
  }) = _SpeakingTopicModel;

  factory SpeakingTopicModel.fromJson(Map<String, dynamic> json) =>
      _$SpeakingTopicModelFromJson(json);
}

extension ChurchModelX on ChurchModel {
  ChurchDetail toEntity() {
    return ChurchDetail(
      id: id,
      name: name,
      denomination: denomination,
      description: description,
      address: address?.toEntity(),
      phone: phone,
      email: email,
      website: website,
      foundedYear: foundedYear,
      membershipCount: membershipCount,
      serviceTimes: serviceTimes?.toEntity(),
      socialMedia: socialMedia?.toEntity(),
      imageUrl: imageUrl,
      isActive: isActive,
      sortOrder: sortOrder,
      speakers: speakers.map((speaker) => speaker.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension AddressModelX on AddressModel {
  Address toEntity() {
    return Address(
      street: street,
      city: city,
      state: state,
      zipCode: zipCode,
      country: country,
    );
  }
}

extension ServiceTimesModelX on ServiceTimesModel {
  ServiceTimes toEntity() {
    return ServiceTimes(
      sunday: sunday,
      monday: monday,
      tuesday: tuesday,
      wednesday: wednesday,
      thursday: thursday,
      friday: friday,
      saturday: saturday,
      weekdays: weekdays,
    );
  }
}

extension SocialMediaModelX on SocialMediaModel {
  SocialMedia toEntity() {
    return SocialMedia(
      facebook: facebook,
      instagram: instagram,
      twitter: twitter,
      youtube: youtube,
      linkedin: linkedin,
    );
  }
}

extension SpeakerModelX on SpeakerModel {
  Speaker toEntity() {
    return Speaker(
      id: id,
      name: name,
      title: title,
      bio: bio,
      email: email,
      phone: phone,
      yearsOfService: yearsOfService,
      socialMedia: socialMedia?.toEntity(),
      speakingTopics: speakingTopics.map((topic) => topic.toEntity()).toList(),
      sortOrder: sortOrder,
      teachingStyle: teachingStyle,
      bibleApproach: bibleApproach,
      environmentStyle: environmentStyle,
      gender: gender,
      profilePictureUrl: profilePictureUrl,
      isRecommended: isRecommended,
      churchId: churchId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension SpeakerSocialMediaModelX on SpeakerSocialMediaModel {
  SpeakerSocialMedia toEntity() {
    return SpeakerSocialMedia(
      facebook: facebook,
      instagram: instagram,
      twitter: twitter,
      youtube: youtube,
      linkedin: linkedin,
    );
  }
}

extension SpeakingTopicModelX on SpeakingTopicModel {
  SpeakingTopic toEntity() {
    return SpeakingTopic(
      name: name,
      description: description,
      category: category,
    );
  }
}
