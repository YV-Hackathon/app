import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../churches/domain/entities/church.dart';
import '../../../churches/domain/entities/church_section.dart';
import '../../../churches/presentation/widgets/church_carousel_header.dart';
import '../../../churches/presentation/widgets/filter_chips.dart';
import '../../../churches/presentation/widgets/church_section.dart';

class ChurchesPage extends StatefulWidget {
  const ChurchesPage({super.key});

  @override
  State<ChurchesPage> createState() => _ChurchesPageState();
}

class _ChurchesPageState extends State<ChurchesPage> {
  Church? _selectedChurch;
  List<String> _selectedFilters = [];

  // Mock data - in a real app, this would come from a service/repository
  final List<Church> _featuredChurches = [
    const Church(
      id: '1',
      name: 'Life.Church Edmond',
      description:
          'This is the start of the church bio, where pastors state their beliefs...',
      imageUrl: 'assets/images/church_avatars/church_avatar_2.png',
      distance: 4.8,
      rating: 96,
      attributes: ['Contemporary', 'Large'],
    ),
    const Church(
      id: '2',
      name: 'Coffee Creek Church',
      description:
          'This is the start of the church bio, where pastors state their beliefs...',
      imageUrl: 'assets/images/church_avatars/church_avatar_1.png',
      distance: 2.4,
      rating: 89,
      attributes: ['Traditional', 'Medium'],
    ),
    const Church(
      id: '3',
      name: 'Hope Church',
      description:
          'This is the start of the church bio, where pastors state their beliefs...',
      imageUrl: 'assets/images/church_avatars/church_avatar_3.png',
      distance: -1, // Online
      rating: 92,
      attributes: ['Contemporary', 'Online'],
      isOnline: true,
    ),
  ];

  final List<ChurchSection> _churchSections = [
    ChurchSection(
      title: 'Top Picks',
      churches: [
        const Church(
          id: '4',
          name: 'Life.Church Edmond',
          description:
              'This is the start of the church bio, where pastors state their beliefs...',
          imageUrl: 'assets/images/church_avatars/church_avatar_2.png',
          distance: 4.8,
          rating: 96,
          attributes: ['Contemporary'],
        ),
        const Church(
          id: '5',
          name: 'Coffee Creek Church',
          description:
              'This is the start of the church bio, where pastors state their beliefs...',
          imageUrl: 'assets/images/church_avatars/church_avatar_1.png',
          distance: 2.4,
          rating: 89,
          attributes: ['Traditional'],
        ),
        const Church(
          id: '6',
          name: 'Hope Church',
          description:
              'This is the start of the church bio, where pastors state their beliefs...',
          imageUrl: 'assets/images/church_avatars/church_avatar_3.png',
          distance: -1,
          rating: 92,
          attributes: ['Contemporary'],
          isOnline: true,
        ),
      ],
    ),
    ChurchSection(
      title: 'Near You',
      churches: [
        const Church(
          id: '7',
          name: 'Church Name',
          description:
              'This is the start of the church bio, where pastors state their beliefs...',
          imageUrl: 'assets/images/church_avatars/church_avatar_4.png',
          distance: 3.6,
          rating: 85,
          attributes: ['Traditional'],
        ),
        const Church(
          id: '8',
          name: 'Church Name',
          description:
              'This is the start of the church bio, where pastors state their beliefs...',
          imageUrl: 'assets/images/church_avatars/church_avatar_5.png',
          distance: 2.2,
          rating: 88,
          attributes: ['Contemporary'],
        ),
        const Church(
          id: '9',
          name: 'Church Name',
          description:
              'This is the start of the church bio, where pastors state their beliefs...',
          imageUrl: 'assets/images/church_avatars/church_avatar_6.png',
          distance: 8.1,
          rating: 91,
          attributes: ['Traditional'],
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Set the middle church as selected by default
    if (_featuredChurches.isNotEmpty) {
      _selectedChurch = _featuredChurches[1];
    }
  }

  void _onChurchSelected(Church church) {
    setState(() {
      _selectedChurch = church;
    });
  }

  void _onFiltersChanged(List<String> filters) {
    setState(() {
      _selectedFilters = filters;
    });
    // In a real app, you would filter the church data here
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
    return Scaffold(
      backgroundColor: AppColors.tabBarBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Church carousel header
            ChurchCarouselHeader(
              featuredChurches: _featuredChurches,
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Churches For You',
                        style: TextStyle(
                          fontSize: AppFonts.xxl,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          fontFamily: 'DM Sans',
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Showing 124 results',
                        style: TextStyle(
                          fontSize: AppFonts.sm,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFBFBDBD),
                          fontFamily: 'Aktiv Grotesk App',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Filter chips
                  FilterChips(
                    selectedFilters: _selectedFilters,
                    onFiltersChanged: _onFiltersChanged,
                  ),

                  const SizedBox(height: 32),

                  // Church sections
                  ..._churchSections.map((section) {
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
      ),
    );
  }
}
