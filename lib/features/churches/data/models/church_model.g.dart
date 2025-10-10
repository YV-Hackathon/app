// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'church_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChurchModelImpl _$$ChurchModelImplFromJson(Map<String, dynamic> json) =>
    _$ChurchModelImpl(
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
      isActive: json['is_active'] as bool? ?? true,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      speakers: (json['speakers'] as List<dynamic>?)
              ?.map((e) => SpeakerModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      id: (json['id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$ChurchModelImplToJson(_$ChurchModelImpl instance) =>
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
      'speakers': instance.speakers,
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$AddressModelImpl _$$AddressModelImplFromJson(Map<String, dynamic> json) =>
    _$AddressModelImpl(
      street: json['street'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zip_code'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$$AddressModelImplToJson(_$AddressModelImpl instance) =>
    <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'zip_code': instance.zipCode,
      'country': instance.country,
    };

_$ServiceTimesModelImpl _$$ServiceTimesModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceTimesModelImpl(
      sunday:
          (json['sunday'] as List<dynamic>?)?.map((e) => e as String).toList(),
      monday:
          (json['monday'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tuesday:
          (json['tuesday'] as List<dynamic>?)?.map((e) => e as String).toList(),
      wednesday: (json['wednesday'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      thursday: (json['thursday'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      friday:
          (json['friday'] as List<dynamic>?)?.map((e) => e as String).toList(),
      saturday: (json['saturday'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      weekdays: (json['weekdays'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$ServiceTimesModelImplToJson(
        _$ServiceTimesModelImpl instance) =>
    <String, dynamic>{
      'sunday': instance.sunday,
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
      'weekdays': instance.weekdays,
    };

_$SocialMediaModelImpl _$$SocialMediaModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SocialMediaModelImpl(
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      twitter: json['twitter'] as String?,
      youtube: json['youtube'] as String?,
      linkedin: json['linkedin'] as String?,
    );

Map<String, dynamic> _$$SocialMediaModelImplToJson(
        _$SocialMediaModelImpl instance) =>
    <String, dynamic>{
      'facebook': instance.facebook,
      'instagram': instance.instagram,
      'twitter': instance.twitter,
      'youtube': instance.youtube,
      'linkedin': instance.linkedin,
    };

_$SpeakerModelImpl _$$SpeakerModelImplFromJson(Map<String, dynamic> json) =>
    _$SpeakerModelImpl(
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
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      teachingStyle: json['teaching_style'] == null
          ? TeachingStyle.warmAndConversational
          : const TeachingStyleConverter()
              .fromJson(json['teaching_style'] as String),
      bibleApproach: json['bible_approach'] == null
          ? BibleApproach.balanced
          : const BibleApproachConverter()
              .fromJson(json['bible_approach'] as String),
      environmentStyle: json['environment_style'] == null
          ? EnvironmentStyle.blended
          : const EnvironmentStyleConverter()
              .fromJson(json['environment_style'] as String),
      gender: _$JsonConverterFromJson<String, Gender>(
          json['gender'], const GenderConverter().fromJson),
      profilePictureUrl: json['profile_picture_url'] as String?,
      isRecommended: json['is_recommended'] as bool? ?? false,
      id: (json['id'] as num).toInt(),
      churchId: (json['church_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$SpeakerModelImplToJson(_$SpeakerModelImpl instance) =>
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
      'gender': _$JsonConverterToJson<String, Gender>(
          instance.gender, const GenderConverter().toJson),
      'profile_picture_url': instance.profilePictureUrl,
      'is_recommended': instance.isRecommended,
      'id': instance.id,
      'church_id': instance.churchId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$SpeakerSocialMediaModelImpl _$$SpeakerSocialMediaModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SpeakerSocialMediaModelImpl(
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      twitter: json['twitter'] as String?,
      youtube: json['youtube'] as String?,
      linkedin: json['linkedin'] as String?,
    );

Map<String, dynamic> _$$SpeakerSocialMediaModelImplToJson(
        _$SpeakerSocialMediaModelImpl instance) =>
    <String, dynamic>{
      'facebook': instance.facebook,
      'instagram': instance.instagram,
      'twitter': instance.twitter,
      'youtube': instance.youtube,
      'linkedin': instance.linkedin,
    };

_$SpeakingTopicModelImpl _$$SpeakingTopicModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SpeakingTopicModelImpl(
      name: json['name'] as String,
      description: json['description'] as String?,
      category: $enumDecode(_$SpeakingTopicCategoryEnumMap, json['category']),
    );

Map<String, dynamic> _$$SpeakingTopicModelImplToJson(
        _$SpeakingTopicModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'category': _$SpeakingTopicCategoryEnumMap[instance.category]!,
    };

const _$SpeakingTopicCategoryEnumMap = {
  SpeakingTopicCategory.preaching: 'preaching',
  SpeakingTopicCategory.teaching: 'teaching',
  SpeakingTopicCategory.counseling: 'counseling',
  SpeakingTopicCategory.leadership: 'leadership',
  SpeakingTopicCategory.evangelism: 'evangelism',
  SpeakingTopicCategory.worship: 'worship',
  SpeakingTopicCategory.youth: 'youth',
  SpeakingTopicCategory.marriage: 'marriage',
  SpeakingTopicCategory.family: 'family',
  SpeakingTopicCategory.prayer: 'prayer',
  SpeakingTopicCategory.other: 'other',
};
