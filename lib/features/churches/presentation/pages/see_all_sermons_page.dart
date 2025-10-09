import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../domain/entities/sermon.dart';
import '../widgets/sermon_card.dart';

class SeeAllSermonsPage extends StatelessWidget {
  final List<Sermon> sermons;
  final String? sourceName; // Church name or Pastor name
  final String? sourceType; // 'church' or 'pastor'

  const SeeAllSermonsPage({
    super.key,
    required this.sermons,
    this.sourceName,
    this.sourceType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tabBarBackground,
      appBar: AppBar(
        backgroundColor: AppColors.tabBarBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          _getPageTitle(),
          style: const TextStyle(
            color: AppColors.white,
            fontSize: AppFonts.lg,
            fontWeight: FontWeight.w500,
            fontFamily: 'Aktiv Grotesk App',
          ),
        ),
        centerTitle: true,
      ),
      body: _buildSermonsGrid(),
    );
  }

  String _getPageTitle() {
    if (sourceName != null && sourceType != null) {
      return '$sourceName Sermons';
    }
    return 'All Sermons';
  }

  Widget _buildSermonsGrid() {
    if (sermons.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_circle_outline, size: 64, color: Color(0xFF474545)),
            SizedBox(height: 16),
            Text(
              'No sermons available',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
                fontFamily: 'Aktiv Grotesk App',
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Check back later for new content',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFFBFBDBD),
                fontFamily: 'Aktiv Grotesk App',
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: sermons.length,
      itemBuilder: (context, index) {
        final sermon = sermons[index];
        return SermonCard(
          sermon: sermon,
          onTap: () {
            // TODO: Navigate to sermon detail page or play sermon
            _handleSermonTap(context, sermon);
          },
        );
      },
    );
  }

  void _handleSermonTap(BuildContext context, Sermon sermon) {
    // For now, show a simple dialog. In a real app, you'd navigate to a sermon detail page
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF232121),
            title: Text(
              sermon.title,
              style: const TextStyle(
                color: AppColors.white,
                fontFamily: 'Aktiv Grotesk App',
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pastor: ${sermon.pastorName}',
                  style: const TextStyle(
                    color: Color(0xFFBFBDBD),
                    fontFamily: 'Aktiv Grotesk App',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Duration: ${sermon.duration}',
                  style: const TextStyle(
                    color: Color(0xFFBFBDBD),
                    fontFamily: 'Aktiv Grotesk App',
                  ),
                ),
                if (sermon.serviceTime != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Service: ${sermon.serviceTime}',
                    style: const TextStyle(
                      color: Color(0xFFBFBDBD),
                      fontFamily: 'Aktiv Grotesk App',
                    ),
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: AppColors.white,
                    fontFamily: 'Aktiv Grotesk App',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // TODO: Implement sermon playback
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: const Color(0xFF121212),
                ),
                child: const Text(
                  'Play',
                  style: TextStyle(
                    fontFamily: 'Aktiv Grotesk App',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
