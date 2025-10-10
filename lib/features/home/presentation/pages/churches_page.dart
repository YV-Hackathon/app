import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../churches/domain/entities/church.dart';
import '../../../churches/domain/entities/church_section.dart';
import '../../../churches/presentation/widgets/church_carousel_header.dart';
import '../../../churches/presentation/widgets/church_section.dart';
import '../../../churches/presentation/providers/church_recommendation_provider.dart';

class ChurchesPage extends ConsumerStatefulWidget {
  const ChurchesPage({super.key});

  @override
  ConsumerState<ChurchesPage> createState() => _ChurchesPageState();
}

class _ChurchesPageState extends ConsumerState<ChurchesPage> {
  Church? _selectedChurch;

  // TODO: Get actual user ID from authentication state
  static const int _userId = 6;

  @override
  void initState() {
    super.initState();
  }

  void _onChurchSelected(Church church) {
    setState(() {
      _selectedChurch = church;
    });
  }

  void _onChurchTap(Church church) {
    // Navigate to church detail page
    context.push('/church/${church.id}');
  }

  void _onSeeAllTap(String sectionTitle) {
    // Navigate to see all page for this section
    final encodedTitle = sectionTitle.toLowerCase().replaceAll(' ', '-');
    context.push('/churches/see-all/$encodedTitle');
  }

  @override
  Widget build(BuildContext context) {
    final churchRecommendationsAsync = ref.watch(
      churchRecommendationNotifierProvider(_userId),
    );

    return Scaffold(
      backgroundColor: AppColors.tabBarBackground,
      body: churchRecommendationsAsync.when(
        data: (churches) {
          // Set selected church if not already set
          if (_selectedChurch == null && churches.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _selectedChurch =
                    churches.length > 1 ? churches[1] : churches.first;
              });
            });
          }

          // Create church sections from API data
          final churchSections = _createChurchSections(churches);

          return SingleChildScrollView(
            child: Column(
              children: [
                // Church carousel header
                ChurchCarouselHeader(
                  featuredChurches: churches.take(3).toList(),
                  selectedChurch: _selectedChurch,
                  onChurchSelected: _onChurchSelected,
                ),

                // Main content
                Container(
                  color: AppColors.tabBarBackground,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),

                      // Page title and results count
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Churches For You',
                            style: TextStyle(
                              fontSize: AppFonts.xxl,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                              fontFamily: 'DM Sans',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Showing ${churches.length} results',
                            style: const TextStyle(
                              fontSize: AppFonts.sm,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFBFBDBD),
                              fontFamily: 'Aktiv Grotesk App',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Church sections
                      ...churchSections.map((section) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: ChurchSectionWidget(
                            section: section,
                            onChurchTap: _onChurchTap,
                            onSeeAllTap: () => _onSeeAllTap(section.title),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading:
            () => const Scaffold(
              backgroundColor: AppColors.tabBarBackground,
              body: Center(
                child: CircularProgressIndicator(color: AppColors.white),
              ),
            ),
        error:
            (error, stackTrace) => Scaffold(
              backgroundColor: AppColors.tabBarBackground,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: AppColors.white,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load churches',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      style: const TextStyle(
                        color: Color(0xFFBFBDBD),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ref.invalidate(
                          churchRecommendationNotifierProvider(_userId),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }

  List<ChurchSection> _createChurchSections(List<Church> churches) {
    if (churches.isEmpty) return [];

    // Split churches into different sections
    final topPicks = churches.take(3).toList();
    final nearYou = churches.skip(3).take(3).toList();

    return [
      if (topPicks.isNotEmpty)
        ChurchSection(title: 'Top Picks', churches: topPicks),
      if (nearYou.isNotEmpty)
        ChurchSection(title: 'Near You', churches: nearYou),
    ];
  }
}
