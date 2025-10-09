import '../../domain/entities/sermon_clip.dart';
import '../../domain/entities/speaker.dart';
import 'sermon_recommendation_response.dart';

extension SermonRecommendationMapper on SermonRecommendation {
  SermonClip toEntity() {
    return SermonClip(
      id: sermonId.toString(),
      title: title,
      videoUrl: gcsUrl,
      thumbnailUrl: gcsUrl, // Using video URL as thumbnail for now
      description: description,
      speaker: Speaker(
        id: speaker.id.toString(),
        name: speaker.name,
        imageUrl: '', // No image URL in response
        isSelected: false,
      ),
      churchName: speaker.title, // Using speaker title as church name
      churchLogo: '', // No church logo in response
      duration: const Duration(seconds: 0), // Not provided in response
      currentTime: const Duration(seconds: 0),
      publishedAt: DateTime.now(), // Not provided in response
      viewCount: 0,
      likeCount: 0,
      attributes: matchingPreferences,
      matchingPreferences: matchingPreferences.length,
    );
  }
}

extension SermonRecommendationResponseMapper on SermonRecommendationResponse {
  List<SermonClip> toSermonClips() {
    return recommendations.map((rec) => rec.toEntity()).toList();
  }
}
