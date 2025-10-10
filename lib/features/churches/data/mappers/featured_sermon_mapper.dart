import '../../domain/entities/sermon.dart';
import '../models/featured_sermons_response.dart';

class FeaturedSermonMapper {
  static Sermon toSermonEntity(FeaturedSermonItem featuredSermonItem) {
    final sermon = featuredSermonItem.sermon;
    final speaker = sermon.speaker;

    // Format duration - we don't have duration in the API response, so we'll use a placeholder
    // In a real app, you might want to calculate this from video metadata
    const String duration = '0:00';

    return Sermon(
      id: sermon.id.toString(),
      title: sermon.title,
      pastorName: speaker.name,
      thumbnailUrl:
          speaker.profilePictureUrl ??
          'assets/images/church_avatars/church_avatar_1.png',
      duration: duration,
      isLive: false, // Featured sermons are typically not live
      serviceTime: null, // We don't have service time info in the API response
    );
  }

  static List<Sermon> toSermonEntities(
    List<FeaturedSermonItem> featuredSermonItems,
  ) {
    return featuredSermonItems.map(toSermonEntity).toList();
  }
}
