import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/sermon.dart';
import '../../domain/entities/church_detail.dart';
import '../../data/models/featured_sermons_response.dart';

class SermonCard extends StatelessWidget {
  final Sermon? sermon;
  final FeaturedSermonItem? featuredSermonItem;
  final VoidCallback? onTap;

  const SermonCard({
    super.key,
    this.sermon,
    this.featuredSermonItem,
    this.onTap,
  }) : assert(
         sermon != null || featuredSermonItem != null,
         'Either sermon or featuredSermonItem must be provided',
       );

  // Factory constructor for backward compatibility
  const SermonCard.fromSermon({
    super.key,
    required Sermon sermon,
    VoidCallback? onTap,
  }) : sermon = sermon,
       featuredSermonItem = null,
       onTap = onTap;

  // Factory constructor for featured sermon data
  const SermonCard.fromFeaturedSermon({
    super.key,
    required FeaturedSermonItem featuredSermonItem,
    VoidCallback? onTap,
  }) : sermon = null,
       featuredSermonItem = featuredSermonItem,
       onTap = onTap;

  @override
  Widget build(BuildContext context) {
    // Determine which data source to use
    final isFeaturedSermon = featuredSermonItem != null;
    final sermonData = featuredSermonItem?.sermon;
    final speaker = featuredSermonItem?.sermon.speaker;

    // Get display data
    final title = isFeaturedSermon ? sermonData!.title : sermon!.title;
    final pastorName = isFeaturedSermon ? speaker!.name : sermon!.pastorName;
    final thumbnailUrl =
        isFeaturedSermon
            ? (speaker!.profilePictureUrl ??
                'assets/images/church_avatars/church_avatar_1.png')
            : sermon!.thumbnailUrl;
    final duration =
        isFeaturedSermon
            ? '0:00'
            : sermon!.duration; // Placeholder for featured sermons
    final description = isFeaturedSermon ? sermonData!.description : null;
    final isClip = isFeaturedSermon ? sermonData!.isClip : false;
    final createdAt = isFeaturedSermon ? sermonData!.createdAt : null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 212,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video thumbnail
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: _getImageProvider(thumbnailUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Play button overlay
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Text(
                            duration,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                              fontFamily: 'Aktiv Grotesk App',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Clip indicator for featured sermons
                  if (isFeaturedSermon && isClip)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'CLIP',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                            fontFamily: 'Aktiv Grotesk App',
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Speaker info
            Row(
              children: [
                // Speaker avatar (small)
                if (isFeaturedSermon && speaker!.profilePictureUrl != null)
                  Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(speaker.profilePictureUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Expanded(
                  child: Text(
                    pastorName,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFFBFBDBD),
                      fontFamily: 'Aktiv Grotesk App',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // Sermon title
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.white,
                fontFamily: 'Aktiv Grotesk App',
                height: 1.25,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            // Description for featured sermons (if available)
            if (isFeaturedSermon &&
                description != null &&
                description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFBFBDBD),
                  fontFamily: 'Aktiv Grotesk App',
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            // Additional info for featured sermons
            if (isFeaturedSermon) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  // Teaching style indicator
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF474545)),
                    ),
                    child: Text(
                      _getTeachingStyleDisplay(speaker!.teachingStyle),
                      style: const TextStyle(
                        fontSize: 8,
                        color: AppColors.white,
                        fontFamily: 'Aktiv Grotesk App',
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),

                  // Date indicator
                  if (createdAt != null)
                    Text(
                      _formatDate(createdAt),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFFBFBDBD),
                        fontFamily: 'Aktiv Grotesk App',
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  ImageProvider _getImageProvider(String url) {
    if (url.startsWith('http')) {
      return NetworkImage(url);
    } else {
      return AssetImage(url);
    }
  }

  String _getTeachingStyleDisplay(TeachingStyle style) {
    switch (style) {
      case TeachingStyle.warmAndConversational:
        return 'Warm';
      case TeachingStyle.calmAndReflective:
        return 'Calm';
      case TeachingStyle.passionateAndHighEnergy:
        return 'Passionate';
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return 'Today';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      } else if (difference.inDays < 30) {
        return '${(difference.inDays / 7).floor()}w ago';
      } else {
        return '${(difference.inDays / 30).floor()}mo ago';
      }
    } catch (e) {
      return '';
    }
  }
}
