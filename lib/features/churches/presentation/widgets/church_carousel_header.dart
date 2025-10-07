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
  late PageController _pageController;
  int _currentIndex = 1; // Start with middle church

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentIndex,
      viewportFraction: 0.6,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (widget.onChurchSelected != null &&
        index < widget.featuredChurches.length) {
      widget.onChurchSelected!(widget.featuredChurches[index]);
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
              // Church carousel
              SizedBox(
                height: 148,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: widget.featuredChurches.length,
                  itemBuilder: (context, index) {
                    final church = widget.featuredChurches[index];
                    final isCenter = index == _currentIndex;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.symmetric(
                        horizontal: isCenter ? 0 : 20,
                        vertical: isCenter ? 0 : 20,
                      ),
                      child: Center(
                        child: _buildChurchAvatar(
                          church: church,
                          size: isCenter ? 124.0 : 86.0,
                          isSelected: isCenter,
                        ),
                      ),
                    );
                  },
                ),
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
          image: NetworkImage(church.imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow:
            isSelected
                ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
                : null,
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
