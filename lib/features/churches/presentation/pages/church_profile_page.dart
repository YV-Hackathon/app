import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../domain/entities/church.dart';
import '../../domain/entities/pastor.dart';
import '../../domain/entities/sermon.dart';
import '../widgets/pastor_card.dart';
import '../widgets/sermon_card.dart';

class ChurchProfilePage extends StatefulWidget {
  final Church church;

  const ChurchProfilePage({super.key, required this.church});

  @override
  State<ChurchProfilePage> createState() => _ChurchProfilePageState();
}

class _ChurchProfilePageState extends State<ChurchProfilePage> {
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tabBarBackground,
      body: CustomScrollView(
        slivers: [
          // Header with church image
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
              'Churches',
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
                    image: AssetImage(widget.church.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Church profile content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Church info section with padding
                _buildChurchInfo(),
                const SizedBox(height: 32),

                // Pastors section with padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: _buildPastorsSection(context),
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

  Widget _buildChurchInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Church avatar and basic info
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
                    image: NetworkImage(widget.church.imageUrl),
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
                      widget.church.name,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        fontFamily: 'DM Sans',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '8,000 Average Weekly Attendance',
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

        // Church attributes
        SizedBox(
          height: 36, // Fixed height to prevent layout shifts
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children:
                    widget.church.attributes.map((attribute) {
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

        // Church description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            widget.church.description,
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
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
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

        // Location and contact info
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 16,
                    color: AppColors.white,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '13248 Roscoe Blvd Sun Valley, CA 91352',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.white,
                        fontFamily: 'Aktiv Grotesk App',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
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
                    child: _buildContactButton(
                      icon: Icons.email,
                      label: 'Contact',
                    ),
                  ),
                ],
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

  Widget _buildPastorsSection(BuildContext context) {
    final pastors = _getMockPastors();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Pastors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                fontFamily: 'Aktiv Grotesk App',
              ),
            ),
            GestureDetector(
              onTap: () {
                context.push('/pastors/see-all');
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
        ...pastors.map(
          (pastor) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: PastorCard(
              pastor: pastor,
              onTap: () {
                context.push('/pastor/${pastor.id}');
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
                  context.push('/church/${widget.church.id}/sermons/see-all');
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
          height: 200,
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

  List<Pastor> _getMockPastors() {
    return [
      const Pastor(
        id: '1',
        name: 'John McArthur',
        title: 'Former Pastor',
        imageUrl: 'assets/images/church_avatars/church_avatar_1.png',
        tenure: '1969-2025',
        description:
            'Former pastor with decades of experience in expository preaching.',
        attributes: ['Expository', 'Author', 'Radio Host'],
      ),
      const Pastor(
        id: '2',
        name: 'Mike Riccardi',
        title: 'Senior Pastor',
        imageUrl: 'assets/images/church_avatars/church_avatar_2.png',
        tenure: '2012-Present',
        description:
            'Current senior pastor focused on biblical teaching and discipleship.',
        attributes: ['Expository', 'Discipleship', 'Teaching'],
      ),
      const Pastor(
        id: '3',
        name: 'Judy Kim',
        title: "Woman's Pastor",
        imageUrl: 'assets/images/church_avatars/church_avatar_3.png',
        tenure: '2025-Present',
        description:
            'Women\'s ministry pastor dedicated to serving and equipping women.',
        attributes: ['Women\'s Ministry', 'Discipleship', 'Community'],
      ),
    ];
  }

  List<Sermon> _getMockSermons() {
    return [
      const Sermon(
        id: '1',
        title: 'The Gift of the Gospel',
        pastorName: 'John McArthur',
        thumbnailUrl: 'assets/images/church_avatars/church_avatar_1.png',
        duration: '36:24',
      ),
      const Sermon(
        id: '2',
        title: 'Free Will',
        pastorName: 'John McArthur',
        thumbnailUrl: 'assets/images/church_avatars/church_avatar_2.png',
        duration: '46:12',
      ),
      const Sermon(
        id: '3',
        title: 'Back to School Summer Camp Devotional',
        pastorName: 'Partner Name',
        thumbnailUrl: 'assets/images/church_avatars/church_avatar_3.png',
        duration: '6:24',
      ),
      const Sermon(
        id: '4',
        title: 'Desiring God',
        pastorName: 'John McArthur',
        thumbnailUrl: 'assets/images/church_avatars/church_avatar_4.png',
        duration: '36:24',
      ),
    ];
  }
}
