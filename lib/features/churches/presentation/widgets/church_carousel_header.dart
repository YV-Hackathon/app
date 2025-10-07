import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../domain/entities/church.dart';

class ChurchCarouselHeader extends StatefulWidget {
  final List<Church> featuredChurches;
  final Church? selectedChurch;
  final Function(Church)? onChurchSelected;

  const ChurchCarouselHeader({
    super.key,
    required this.featuredChurches,
    this.selectedChurch,
    this.onChurchSelected,
  });

  @override
  State<ChurchCarouselHeader> createState() => _ChurchCarouselHeaderState();
}

class _ChurchCarouselHeaderState extends State<ChurchCarouselHeader> {
  int _currentIndex = 1; // Start with middle church

  @override
  void initState() {
    super.initState();
    // Initialize with the first church if available
    if (widget.featuredChurches.isNotEmpty) {
      _currentIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 358,
      decoration: const BoxDecoration(
        color: AppColors.tabBarBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          // Background blob effect
          Positioned(
            right: -69,
            bottom: -88,
            child: Container(
              width: 358,
              height: 377,
              decoration: BoxDecoration(
                color: const Color(0xFF217B48).withOpacity(0.36),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF217B48).withOpacity(0.36),
                    blurRadius: 62,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24,
            children: [
              // Church carousel - stacked layout
              SizedBox(
                height: 148,
                child: Center(child: _buildStackedAvatars()),
              ),
              if (widget.selectedChurch != null)
                _buildSelectedChurchInfo(widget.selectedChurch!),
              _buildPageIndicators(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStackedAvatars() {
    if (widget.featuredChurches.isEmpty) return const SizedBox.shrink();

    // Get the three avatars to display (previous, current, next)
    final currentIndex = _currentIndex;
    final previousIndex =
        currentIndex > 0
            ? currentIndex - 1
            : widget.featuredChurches.length - 1;
    final nextIndex =
        currentIndex < widget.featuredChurches.length - 1
            ? currentIndex + 1
            : 0;

    return SizedBox(
      width: 200, // Total width for the stacked avatars
      height: 124,
      child: GestureDetector(
        onPanStart: (details) {
          print('Pan started at: ${details.localPosition}');
        },
        onPanUpdate: (details) {
          // Optional: Add visual feedback during swipe
          // You could add a slight scale or opacity change here
        },
        onPanEnd: (details) {
          // Detect swipe direction based on velocity
          final velocity = details.velocity.pixelsPerSecond.dx;
          const swipeThreshold = 300.0; // Minimum velocity for swipe detection

          print('Pan ended with velocity: $velocity');

          if (velocity > swipeThreshold) {
            // Swipe right - go to previous
            final prevIndex =
                currentIndex > 0
                    ? currentIndex - 1
                    : widget.featuredChurches.length - 1;
            print('Swipe right detected, navigating to: $prevIndex');
            _navigateToIndex(prevIndex);
          } else if (velocity < -swipeThreshold) {
            // Swipe left - go to next
            final nextIndex =
                currentIndex < widget.featuredChurches.length - 1
                    ? currentIndex + 1
                    : 0;
            print('Swipe left detected, navigating to: $nextIndex');
            _navigateToIndex(nextIndex);
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Previous avatar (left, partially visible)
            Positioned(
              left: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _navigateToIndex(previousIndex),
                child: _buildChurchAvatar(
                  church: widget.featuredChurches[previousIndex],
                  size: 86.0,
                  isSelected: false,
                ),
              ),
            ),
            // Next avatar (right, partially visible)
            Positioned(
              right: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _navigateToIndex(nextIndex),
                child: _buildChurchAvatar(
                  church: widget.featuredChurches[nextIndex],
                  size: 86.0,
                  isSelected: false,
                ),
              ),
            ),
            // Current avatar (center, fully visible, on top)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _navigateToIndex(currentIndex),
              child: _buildChurchAvatar(
                church: widget.featuredChurches[currentIndex],
                size: 124.0,
                isSelected: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (widget.onChurchSelected != null) {
      widget.onChurchSelected!(widget.featuredChurches[index]);
    }
  }

  Widget _buildChurchAvatar({
    required Church church,
    required double size,
    required bool isSelected,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size),
        image: DecorationImage(
          image: AssetImage(church.imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isSelected ? 0.3 : 0.2),
            blurRadius: isSelected ? 8 : 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.featuredChurches.length, (index) {
        final isActive = index == _currentIndex;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 8 : 6,
          height: isActive ? 8 : 6,
          decoration: BoxDecoration(
            color:
                isActive
                    ? const Color(0xFF217B48)
                    : AppColors.white.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Widget _buildSelectedChurchInfo(Church church) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.tabBarBackground,
          borderRadius: BorderRadius.circular(124),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 28,
              offset: const Offset(8, 46),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 21,
              offset: const Offset(4, 20),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 11,
              offset: const Offset(1, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    church.name,
                    style: const TextStyle(
                      fontSize: AppFonts.lg,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    church.ratingText,
                    style: const TextStyle(
                      fontSize: AppFonts.xs,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFBFBDBD),
                      fontFamily: 'Aktiv Grotesk App',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEBEB),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Text(
                'Learn More',
                style: TextStyle(
                  fontSize: AppFonts.sm,
                  fontWeight: FontWeight.bold,
                  color: AppColors.tabBarBackground,
                  fontFamily: 'Aktiv Grotesk App',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
