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
      recommendedSermons: (json['recommended_sermons'] as List<dynamic>?)
          ?.map((e) => RecommendedSermon.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$OnboardingSubmissionResponseImplToJson(
        _$OnboardingSubmissionResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user_id': instance.userId,
      'user': instance.user,
      'data': instance.data,
      'recommended_sermons': instance.recommendedSermons,
    };

_$RecommendedSermonImpl _$$RecommendedSermonImplFromJson(
        Map<String, dynamic> json) =>
    _$RecommendedSermonImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      gcsUrl: json['gcs_url'] as String,
      isClip: json['is_clip'] as bool?,
      id: (json['id'] as num).toInt(),
      speakerId: (json['speaker_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      speaker: json['speaker'] == null
          ? null
          : RecommendedSpeaker.fromJson(
              json['speaker'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RecommendedSermonImplToJson(
        _$RecommendedSermonImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'gcs_url': instance.gcsUrl,
      'is_clip': instance.isClip,
      'id': instance.id,
      'speaker_id': instance.speakerId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'speaker': instance.speaker,
    };

_$RecommendedSpeakerImpl _$$RecommendedSpeakerImplFromJson(
        Map<String, dynamic> json) =>
    _$RecommendedSpeakerImpl(
      name: json['name'] as String,
      title: json['title'] as String?,
      bio: json['bio'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      yearsOfService: (json['years_of_service'] as num?)?.toInt(),
      socialMedia: json['social_media'] as Map<String, dynamic>?,
      speakingTopics: (json['speaking_topics'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sortOrder: (json['sort_order'] as num?)?.toInt(),
      teachingStyle: json['teaching_style'] as String?,
      bibleApproach: json['bible_approach'] as String?,
      environmentStyle: json['environment_style'] as String?,
      gender: json['gender'] as String?,
      profilePictureUrl: json['profile_picture_url'] as String?,
      isRecommended: json['is_recommended'] as bool?,
      id: (json['id'] as num).toInt(),
      churchId: (json['church_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      church: json['church'] == null
          ? null
          : RecommendedChurch.fromJson(json['church'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RecommendedSpeakerImplToJson(
        _$RecommendedSpeakerImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'bio': instance.bio,
      'email': instance.email,
      'phone': instance.phone,
      'years_of_service': instance.yearsOfService,
      'social_media': instance.socialMedia,
      'speaking_topics': instance.speakingTopics,
      'sort_order': instance.sortOrder,
      'teaching_style': instance.teachingStyle,
      'bible_approach': instance.bibleApproach,
      'environment_style': instance.environmentStyle,
      'gender': instance.gender,
      'profile_picture_url': instance.profilePictureUrl,
      'is_recommended': instance.isRecommended,
      'id': instance.id,
      'church_id': instance.churchId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'church': instance.church,
    };

_$RecommendedChurchImpl _$$RecommendedChurchImplFromJson(
        Map<String, dynamic> json) =>
    _$RecommendedChurchImpl(
      name: json['name'] as String,
      denomination: json['denomination'] as String?,
      description: json['description'] as String?,
      address: json['address'] as Map<String, dynamic>?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      foundedYear: (json['founded_year'] as num?)?.toInt(),
      membershipCount: (json['membership_count'] as num?)?.toInt(),
      serviceTimes: json['service_times'] as Map<String, dynamic>?,
      socialMedia: json['social_media'] as Map<String, dynamic>?,
      imageUrl: json['image_url'] as String?,
      isActive: json['is_active'] as bool?,
      sortOrder: (json['sort_order'] as num?)?.toInt(),
      id: (json['id'] as num).toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$RecommendedChurchImplToJson(
        _$RecommendedChurchImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'denomination': instance.denomination,
      'description': instance.description,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
      'website': instance.website,
      'founded_year': instance.foundedYear,
      'membership_count': instance.membershipCount,
      'service_times': instance.serviceTimes,
      'social_media': instance.socialMedia,
      'image_url': instance.imageUrl,
      'is_active': instance.isActive,
      'sort_order': instance.sortOrder,
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
