// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sermon_clip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SermonClipImpl _$$SermonClipImplFromJson(Map<String, dynamic> json) =>
    _$SermonClipImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      videoUrl: json['videoUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      description: json['description'] as String,
      speaker: Speaker.fromJson(json['speaker'] as Map<String, dynamic>),
      churchName: json['churchName'] as String,
      churchLogo: json['churchLogo'] as String,
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      currentTime: Duration(microseconds: (json['currentTime'] as num).toInt()),
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      attributes: (json['attributes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      matchingPreferences: (json['matchingPreferences'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$SermonClipImplToJson(_$SermonClipImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'videoUrl': instance.videoUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'description': instance.description,
      'speaker': instance.speaker,
      'churchName': instance.churchName,
      'churchLogo': instance.churchLogo,
      'duration': instance.duration.inMicroseconds,
      'currentTime': instance.currentTime.inMicroseconds,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'viewCount': instance.viewCount,
      'likeCount': instance.likeCount,
      'attributes': instance.attributes,
      'matchingPreferences': instance.matchingPreferences,
    };
