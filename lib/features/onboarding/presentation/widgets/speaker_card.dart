import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/speaker.dart';

class SpeakerCard extends StatelessWidget {
  final Speaker speaker;
  final VoidCallback? onTap;

  const SpeakerCard({super.key, required this.speaker, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Speaker Image Container with white border when selected
          Container(
            width: 101, // Always 101px to prevent shifting
            height: 101,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(124),
              border:
                  speaker.isSelected
                      ? Border.all(color: Colors.white, width: 4)
                      : Border.all(
                        color: Colors.transparent,
                        width: 4,
                      ), // Invisible border when not selected
            ),
            child: Container(
              width: 93, // Keep inner container same size
              height: 93,
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(76.911),
                child: _buildImage(),
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Speaker Name
          Text(
            speaker.name,
            style: const TextStyle(
              fontFamily: 'Aktiv Grotesk App',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1.25,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (speaker.imageUrl.isEmpty) {
      print('❌ Empty imageUrl for ${speaker.name}');
      return _buildPlaceholder();
    }

    // Check if it's a local asset or network URL
    if (speaker.imageUrl.startsWith('assets/') ||
        speaker.imageUrl.startsWith('lib/') ||
        !speaker.imageUrl.startsWith('http')) {
      // Local asset
      print('📁 Loading asset for ${speaker.name}: ${speaker.imageUrl}');
      return Image.asset(
        speaker.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('❌ Asset load error for ${speaker.name}: $error');
          return _buildPlaceholder();
        },
      );
    } else {
      // Network image with caching
      return CachedNetworkImage(
        imageUrl: speaker.imageUrl,
        fit: BoxFit.cover,
        placeholder:
            (context, url) => Container(
              color: const Color(0xFF232121),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            ),
        errorWidget: (context, url, error) => _buildPlaceholder(),
      );
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFF232121),
      child: const Icon(Icons.person, color: Colors.white, size: 40),
    );
  }
}
