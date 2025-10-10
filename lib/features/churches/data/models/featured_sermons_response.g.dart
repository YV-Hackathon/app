// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_sermons_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeaturedSermonItemImpl _$$FeaturedSermonItemImplFromJson(
        Map<String, dynamic> json) =>
    _$FeaturedSermonItemImpl(
      churchId: (json['church_id'] as num).toInt(),
      sermonId: (json['sermon_id'] as num).toInt(),
      sortOrder: (json['sort_order'] as num).toInt(),
      isActive: json['is_active'] as bool,
      id: (json['id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      church:
          FeaturedSermonChurch.fromJson(json['church'] as Map<String, dynamic>),
      sermon:
          FeaturedSermonData.fromJson(json['sermon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FeaturedSermonItemImplToJson(
        _$FeaturedSermonItemImpl instance) =>
    <String, dynamic>{
      'church_id': instance.churchId,
      'sermon_id': instance.sermonId,
      'sort_order': instance.sortOrder,
      'is_active': instance.isActive,
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'church': instance.church,
      'sermon': instance.sermon,
    };

_$FeaturedSermonChurchImpl _$$FeaturedSermonChurchImplFromJson(
        Map<String, dynamic> json) =>
    _$FeaturedSermonChurchImpl(
      name: json['name'] as String,
      denomination: json['denomination'] as String,
      description: json['description'] as String?,
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      foundedYear: (json['founded_year'] as num?)?.toInt(),
      membershipCount: (json['membership_count'] as num?)?.toInt(),
      serviceTimes: json['service_times'] == null
          ? null
          : ServiceTimesModel.fromJson(
              json['service_times'] as Map<String, dynamic>),
      socialMedia: json['social_media'] == null
          ? null
          : SocialMediaModel.fromJson(
              json['social_media'] as Map<String, dynamic>),
      imageUrl: json['image_url'] as String?,
      isActive: json['is_active'] as bool,
      sortOrder: (json['sort_order'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$$FeaturedSermonChurchImplToJson(
        _$FeaturedSermonChurchImpl instance) =>
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

_$FeaturedSermonDataImpl _$$FeaturedSermonDataImplFromJson(
        Map<String, dynamic> json) =>
    _$FeaturedSermonDataImpl(
      title: json['title'] as String,
      description: json['description'] as String?,
      gcsUrl: json['gcs_url'] as String,
      isClip: json['is_clip'] as bool,
      id: (json['id'] as num).toInt(),
      speakerId: (json['speaker_id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      speaker: FeaturedSermonSpeaker.fromJson(
          json['speaker'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FeaturedSermonDataImplToJson(
        _$FeaturedSermonDataImpl instance) =>
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

_$FeaturedSermonSpeakerImpl _$$FeaturedSermonSpeakerImplFromJson(
        Map<String, dynamic> json) =>
    _$FeaturedSermonSpeakerImpl(
      name: json['name'] as String,
      title: json['title'] as String?,
      bio: json['bio'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      yearsOfService: (json['years_of_service'] as num?)?.toInt(),
      socialMedia: json['social_media'] == null
          ? null
          : SpeakerSocialMediaModel.fromJson(
              json['social_media'] as Map<String, dynamic>),
      speakingTopics: (json['speaking_topics'] as List<dynamic>?)
              ?.map(
                  (e) => SpeakingTopicModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sortOrder: (json['sort_order'] as num).toInt(),
      teachingStyle: const TeachingStyleConverter()
          .fromJson(json['teaching_style'] as String),
      bibleApproach: const BibleApproachConverter()
          .fromJson(json['bible_approach'] as String),
      environmentStyle: const EnvironmentStyleConverter()
          .fromJson(json['environment_style'] as String),
      gender: const GenderConverter().fromJson(json['gender'] as String),
      profilePictureUrl: json['profile_picture_url'] as String?,
      isRecommended: json['is_recommended'] as bool,
      id: (json['id'] as num).toInt(),
      churchId: (json['church_id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$$FeaturedSermonSpeakerImplToJson(
        _$FeaturedSermonSpeakerImpl instance) =>
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
      'teaching_style':
          const TeachingStyleConverter().toJson(instance.teachingStyle),
      'bible_approach':
          const BibleApproachConverter().toJson(instance.bibleApproach),
      'environment_style':
          const EnvironmentStyleConverter().toJson(instance.environmentStyle),
      'gender': const GenderConverter().toJson(instance.gender),
      'profile_picture_url': instance.profilePictureUrl,
      'is_recommended': instance.isRecommended,
      'id': instance.id,
      'church_id': instance.churchId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
