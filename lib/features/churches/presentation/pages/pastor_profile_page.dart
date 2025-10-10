import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../domain/entities/church.dart';
import '../../domain/entities/pastor.dart';
import '../../domain/entities/sermon.dart';
import '../widgets/church_card.dart';
import '../widgets/sermon_card.dart';

class PastorProfilePage extends StatefulWidget {
  final Pastor pastor;

  const PastorProfilePage({super.key, required this.pastor});

  @override
  State<PastorProfilePage> createState() => _PastorProfilePageState();
}

class _PastorProfilePageState extends State<PastorProfilePage> {
  bool _isFollowing =
      true; // Start as following since the button shows "Following"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tabBarBackground,
      body: CustomScrollView(
        slivers: [
          // Header with pastor image
          SliverAppBar(
            expandedHeight: 228.0,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.tabBarBackground,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              'Back',
              style: TextStyle(
                color: AppColors.white,
                fontSize: AppFonts.lg,
                fontWeight: FontWeight.w500,
                fontFamily: 'Aktiv Grotesk App',
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.pastor.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Pastor profile content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pastor info section with padding
                _buildPastorInfo(),
                const SizedBox(height: 32),

                // Churches section with padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: _buildChurchesSection(context),
                ),
                const SizedBox(height: 32),

                // Featured sermons section
                _buildFeaturedSermonsSection(),
                const SizedBox(height: 100), // Bottom padding for tab bar
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastorInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pastor avatar and basic info
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                    image: AssetImage(widget.pastor.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.pastor.name,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        fontFamily: 'DM Sans',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.pastor.title,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFFBFBDBD),
                        fontFamily: 'Aktiv Grotesk App',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Pastor attributes
        SizedBox(
          height: 36, // Fixed height to prevent layout shifts
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children:
                    widget.pastor.attributes.map((attribute) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF474545)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            attribute,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                              fontFamily: 'Aktiv Grotesk App',
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Pastor description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            widget.pastor.description,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.white,
              fontFamily: 'Aktiv Grotesk App',
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Action buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isFollowing = !_isFollowing;
                    });
                  },
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color:
                          _isFollowing
                              ? Colors.transparent
                              : const Color(0xFFEDEBEB),
                      border:
                          _isFollowing
                              ? Border.all(color: const Color(0xFF474545))
                              : null,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isFollowing) ...[
                          const Icon(
                            Icons.check,
                            size: 16,
                            color: AppColors.white,
                          ),
                          const SizedBox(width: 4),
                        ],
                        Text(
                          _isFollowing ? 'Following' : 'Follow',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color:
                                _isFollowing
                                    ? AppColors.white
                                    : const Color(0xFF121212),
                            fontFamily: 'Aktiv Grotesk App',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF353333),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.share,
                  color: AppColors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF353333),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.more_vert,
                  color: AppColors.white,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Contact info
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Expanded(
                child: _buildContactButton(
                  icon: Icons.language,
                  label: 'Website',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildContactButton(
                  icon: Icons.calendar_today,
                  label: 'Services',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildContactButton(icon: Icons.email, label: 'Contact'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactButton({required IconData icon, required String label}) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        color: const Color(0xFF232121),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: AppColors.white),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
              fontFamily: 'Aktiv Grotesk App',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChurchesSection(BuildContext context) {
    final churches = _getMockChurches();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Churches',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                fontFamily: 'Aktiv Grotesk App',
              ),
            ),
            GestureDetector(
              onTap: () {
                context.push('/pastor/${widget.pastor.id}/churches/see-all');
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      fontFamily: 'Aktiv Grotesk App',
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...churches.map(
          (church) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ChurchCard(
              church: church,
              onTap: () {
                context.push('/church/${church.id}');
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedSermonsSection() {
    final sermons = _getMockSermons();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header with padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Featured Sermons',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  fontFamily: 'Aktiv Grotesk App',
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.push('/pastor/${widget.pastor.id}/sermons/see-all');
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        fontFamily: 'Aktiv Grotesk App',
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Carousel without horizontal padding
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            itemCount: sermons.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index < sermons.length - 1 ? 16 : 0,
                ),
                child: SermonCard(sermon: sermons[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  List<Church> _getMockChurches() {
    return [
      const Church(
        id: '1',
        name: 'Grace Community Church',
        description:
            'A church committed to expository preaching and biblical teaching.',
        imageUrl: 'assets/images/church_avatars/church_avatar_1.png',
        distance: 4.8,
        rating: 96.0,
        attributes: ['Expository', 'Traditional Worship', 'Multilingual'],
      ),
      const Church(
        id: '2',
        name: 'Immanuel Bible Church',
        description: 'A church focused on community and discipleship.',
        imageUrl: 'assets/images/church_avatars/church_avatar_2.png',
        distance: 2.1,
        rating: 94.0,
        attributes: ['Community', 'Discipleship', 'Family-Friendly'],
      ),
      const Church(
        id: '3',
        name: 'Together for the Gospel',
        description:
            'A conference and ministry focused on gospel-centered preaching.',
        imageUrl: 'assets/images/church_avatars/church_avatar_3.png',
        distance: 0.0,
        rating: 98.0,
        attributes: ['Conference', 'Gospel-Centered', 'Teaching'],
      ),
    ];
  }

  List<Sermon> _getMockSermons() {
    return [
      Sermon(
        id: '1',
        title: 'The Gift of the Gospel',
        pastorName: widget.pastor.name,
        thumbnailUrl: 'assets/images/church_avatars/church_avatar_1.png',
        duration: '36:24',
      ),
      Sermon(
        id: '2',
        title: 'Free Will',
        pastorName: widget.pastor.name,
        thumbnailUrl: 'assets/images/church_avatars/church_avatar_2.png',
        duration: '46:12',
      ),
      Sermon(
        id: '3',
        title: 'Desiring God',
        pastorName: widget.pastor.name,
        thumbnailUrl: 'assets/images/church_avatars/church_avatar_3.png',
        duration: '36:24',
      ),
    ];
  }
}
