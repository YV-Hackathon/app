import '../../domain/entities/sermon_clip.dart';
import '../../domain/entities/speaker.dart';
import 'onboarding_submission_response.dart';

extension RecommendedSermonMapper on RecommendedSermon {
  /// Convert recommended sermon to SermonClip entity
  SermonClip toSermonClip() {
    final speakerData = speaker;

    return SermonClip(
      id: id.toString(),
      title: title,
      videoUrl: gcsUrl,
      thumbnailUrl:
          gcsUrl, // Using video URL as thumbnail since it's not provided
      description: description,
      speaker: Speaker(
        id: speakerData?.id.toString() ?? speakerId.toString(),
        name: speakerData?.name ?? 'Unknown Speaker',
        imageUrl: speakerData?.profilePictureUrl ?? '',
        isSelected: false,
      ),
      churchName: speakerData?.church?.name ?? speakerData?.title ?? '',
      churchLogo: speakerData?.church?.imageUrl ?? '',
      duration: const Duration(seconds: 0), // Duration not provided in API
      currentTime: const Duration(seconds: 0),
      publishedAt:
          createdAt != null
              ? DateTime.tryParse(createdAt!) ?? DateTime.now()
              : DateTime.now(),
      viewCount: 0,
      likeCount: 0,
      attributes: _buildAttributes(speakerData),
      matchingPreferences: _buildAttributes(speakerData).length,
    );
  }

  List<String> _buildAttributes(RecommendedSpeaker? speakerData) {
    if (speakerData == null) return [];

    final attributes = <String>[];
    if (speakerData.teachingStyle != null) {
      attributes.add(_formatEnumValue(speakerData.teachingStyle!));
    }
    if (speakerData.bibleApproach != null) {
      attributes.add(_formatEnumValue(speakerData.bibleApproach!));
    }
    if (speakerData.environmentStyle != null) {
      attributes.add(_formatEnumValue(speakerData.environmentStyle!));
    }
    return attributes;
  }

  String _formatEnumValue(String value) {
    return value
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}

extension RecommendedSermonsListMapper on List<RecommendedSermon> {
  /// Convert all recommended sermons to a list of SermonClip entities
  List<SermonClip> toSermonClips() {
    return map((sermon) => sermon.toSermonClip()).toList();
  }
}
