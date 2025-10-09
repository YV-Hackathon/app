import 'package:gloo_hackathon/features/splash/presentation/pages/simple_splash_page.dart';
import 'package:go_router/go_router.dart';
import '../../features/churches/domain/entities/church.dart';
import '../../features/churches/domain/entities/church_section.dart';
import '../../features/churches/domain/entities/pastor.dart';
import '../../features/churches/domain/entities/sermon.dart';
import '../../features/churches/presentation/pages/church_profile_page.dart';
import '../../features/churches/presentation/pages/pastor_profile_page.dart';
import '../../features/churches/presentation/pages/see_all_churches_page.dart';
import '../../features/churches/presentation/pages/see_all_pastors_page.dart';
import '../../features/churches/presentation/pages/see_all_churches_for_pastor_page.dart';
import '../../features/churches/presentation/pages/see_all_sermons_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/unified_onboarding_page.dart';
import '../../features/onboarding/presentation/pages/loading_screen_page.dart';
import '../../features/onboarding/presentation/pages/sermon_clips_page.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    // Legacy routes that redirect to unified onboarding
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    GoRoute(
      path: '/survey-intro',
      name: 'survey-intro',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    GoRoute(
      path: '/question',
      name: 'question',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    GoRoute(
      path: '/teaching-style',
      name: 'teaching-style',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    GoRoute(
      path: '/church-environment',
      name: 'church-environment',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    GoRoute(
      path: '/personalization-intro',
      name: 'personalization-intro',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    GoRoute(
      path: '/personalization-instructions',
      name: 'personalization-instructions',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    GoRoute(
      path: '/playlist-instructions',
      name: 'playlist-instructions',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    GoRoute(
      path: '/loading',
      name: 'loading',
      builder: (context, state) => const LoadingScreenPage(),
    ),
    GoRoute(
      path: '/sermon-clips',
      name: 'sermon-clips',
      builder: (context, state) => const SermonClipsPage(),
    ),

    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),

    GoRoute(
      path: '/church/:churchId',
      name: 'church-profile',
      builder: (context, state) {
        final churchId = state.pathParameters['churchId']!;
        // For now, we'll create a mock church. In a real app, you'd fetch this from a service
        final church = Church(
          id: churchId,
          name: 'Grace Community Church',
          description:
              'Our mission is to glorify God by proclaiming the gospel of Jesus Christ through the power of the Holy Spirit, for the salvation of the lost and edification of the church.',
          imageUrl: 'assets/images/church_avatars/church_avatar_1.png',
          distance: 4.8,
          rating: 96.0,
          attributes: [
            'Expository',
            'Traditional Worship',
            'Multilingual',
            'Family-Friendly',
            'Global Missions',
          ],
        );
        return ChurchProfilePage(church: church);
      },
    ),

    GoRoute(
      path: '/pastor/:pastorId',
      name: 'pastor-profile',
      builder: (context, state) {
        final pastorId = state.pathParameters['pastorId']!;
        // For now, we'll create a mock pastor. In a real app, you'd fetch this from a service
        final pastor = Pastor(
          id: pastorId,
          name: 'John MacArthur',
          title: 'Former Pastor at Grace Community Church',
          imageUrl:
              'assets/speakers/2020dd88fc696356bd502a0956060e1469ac501f.png',
          tenure: '1969-2025',
          description:
              'John MacArthur served as pastor of Grace Community Church for over five decades, faithfully preaching God\'s Word with clarity and conviction to equip believers.',
          attributes: [
            'Expository',
            'Calvinist',
            'Author',
            'Radio Host',
            'Conservative Evangelical',
          ],
        );
        return PastorProfilePage(pastor: pastor);
      },
    ),

    GoRoute(
      path: '/churches/see-all/:sectionTitle',
      name: 'see-all-churches',
      builder: (context, state) {
        final sectionTitle = state.pathParameters['sectionTitle']!;

        // Create mock church sections based on the section title
        // In a real app, you'd fetch this data from a service
        ChurchSection section;

        switch (sectionTitle.toLowerCase().replaceAll(' ', '-')) {
          case 'top-picks':
            section = ChurchSection(
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
                  attributes: ['Contemporary', 'Large'],
                ),
                const Church(
                  id: '5',
                  name: 'Coffee Creek Church',
                  description:
                      'This is the start of the church bio, where pastors state their beliefs...',
                  imageUrl: 'assets/images/church_avatars/church_avatar_1.png',
                  distance: 2.4,
                  rating: 89,
                  attributes: ['Traditional', 'Medium'],
                ),
                const Church(
                  id: '6',
                  name: 'Hope Church',
                  description:
                      'This is the start of the church bio, where pastors state their beliefs...',
                  imageUrl: 'assets/images/church_avatars/church_avatar_3.png',
                  distance: -1,
                  rating: 92,
                  attributes: ['Contemporary', 'Online'],
                  isOnline: true,
                ),
                const Church(
                  id: '10',
                  name: 'Grace Community Church',
                  description:
                      'This is the start of the church bio, where pastors state their beliefs...',
                  imageUrl: 'assets/images/church_avatars/church_avatar_4.png',
                  distance: 3.2,
                  rating: 94,
                  attributes: ['Traditional', 'Large'],
                ),
                const Church(
                  id: '11',
                  name: 'New Life Church',
                  description:
                      'This is the start of the church bio, where pastors state their beliefs...',
                  imageUrl: 'assets/images/church_avatars/church_avatar_5.png',
                  distance: 5.1,
                  rating: 87,
                  attributes: ['Contemporary', 'Medium'],
                ),
              ],
            );
            break;
          case 'near-you':
            section = ChurchSection(
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
                  attributes: ['Traditional', 'Small'],
                ),
                const Church(
                  id: '8',
                  name: 'Church Name',
                  description:
                      'This is the start of the church bio, where pastors state their beliefs...',
                  imageUrl: 'assets/images/church_avatars/church_avatar_5.png',
                  distance: 2.2,
                  rating: 88,
                  attributes: ['Contemporary', 'Medium'],
                ),
                const Church(
                  id: '9',
                  name: 'Church Name',
                  description:
                      'This is the start of the church bio, where pastors state their beliefs...',
                  imageUrl: 'assets/images/church_avatars/church_avatar_6.png',
                  distance: 8.1,
                  rating: 91,
                  attributes: ['Traditional', 'Large'],
                ),
                const Church(
                  id: '12',
                  name: 'First Baptist Church',
                  description:
                      'This is the start of the church bio, where pastors state their beliefs...',
                  imageUrl: 'assets/images/church_avatars/church_avatar_1.png',
                  distance: 1.8,
                  rating: 83,
                  attributes: ['Traditional', 'Small'],
                ),
                const Church(
                  id: '13',
                  name: 'Community Church',
                  description:
                      'This is the start of the church bio, where pastors state their beliefs...',
                  imageUrl: 'assets/images/church_avatars/church_avatar_2.png',
                  distance: 4.3,
                  rating: 90,
                  attributes: ['Contemporary', 'Medium'],
                ),
                const Church(
                  id: '14',
                  name: 'Faith Assembly',
                  description:
                      'This is the start of the church bio, where pastors state their beliefs...',
                  imageUrl: 'assets/images/church_avatars/church_avatar_3.png',
                  distance: 6.7,
                  rating: 86,
                  attributes: ['Traditional', 'Medium'],
                ),
              ],
            );
            break;
          default:
            section = ChurchSection(title: sectionTitle, churches: []);
        }

        return SeeAllChurchesPage(section: section);
      },
    ),

    GoRoute(
      path: '/pastors/see-all',
      name: 'see-all-pastors',
      builder: (context, state) {
        // Create comprehensive mock pastors data
        final pastors = [
          const Pastor(
            id: '1',
            name: 'John MacArthur',
            title: 'Former Pastor',
            imageUrl: 'assets/images/church_avatars/church_avatar_1.png',
            tenure: '1969-2025',
            description:
                'Former pastor with decades of experience in expository preaching and biblical teaching.',
            attributes: ['Expository', 'Author', 'Radio Host', 'Calvinist'],
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
            title: "Women's Pastor",
            imageUrl: 'assets/images/church_avatars/church_avatar_3.png',
            tenure: '2025-Present',
            description:
                'Women\'s ministry pastor dedicated to serving and equipping women.',
            attributes: ['Women\'s Ministry', 'Discipleship', 'Community'],
          ),
          const Pastor(
            id: '4',
            name: 'Tim Keller',
            title: 'Former Pastor',
            imageUrl: 'assets/images/church_avatars/church_avatar_4.png',
            tenure: '1989-2017',
            description:
                'Renowned pastor and author known for his thoughtful approach to urban ministry.',
            attributes: ['Urban Ministry', 'Author', 'Apologetics', 'Reformed'],
          ),
          const Pastor(
            id: '5',
            name: 'Beth Moore',
            title: 'Bible Teacher',
            imageUrl: 'assets/images/church_avatars/church_avatar_5.png',
            tenure: '1994-Present',
            description:
                'Bible teacher and author focused on women\'s discipleship and biblical study.',
            attributes: [
              'Women\'s Ministry',
              'Author',
              'Bible Study',
              'Discipleship',
            ],
          ),
          const Pastor(
            id: '6',
            name: 'Francis Chan',
            title: 'Pastor & Author',
            imageUrl: 'assets/images/church_avatars/church_avatar_6.png',
            tenure: '1994-Present',
            description:
                'Pastor and author known for his passionate preaching and commitment to authentic Christianity.',
            attributes: ['Passionate', 'Author', 'Authentic', 'Evangelical'],
          ),
          const Pastor(
            id: '7',
            name: 'Priscilla Shirer',
            title: 'Bible Teacher',
            imageUrl: 'assets/images/church_avatars/church_avatar_1.png',
            tenure: '2000-Present',
            description:
                'Bible teacher and author focused on helping believers grow in their faith.',
            attributes: ['Women\'s Ministry', 'Author', 'Bible Study', 'Faith'],
          ),
          const Pastor(
            id: '8',
            name: 'David Platt',
            title: 'Pastor & Author',
            imageUrl: 'assets/images/church_avatars/church_avatar_2.png',
            tenure: '2006-Present',
            description:
                'Pastor and author passionate about global missions and radical discipleship.',
            attributes: ['Missions', 'Author', 'Discipleship', 'Global'],
          ),
          const Pastor(
            id: '9',
            name: 'Lisa Harper',
            title: 'Bible Teacher',
            imageUrl: 'assets/images/church_avatars/church_avatar_3.png',
            tenure: '1995-Present',
            description:
                'Bible teacher known for her engaging and practical approach to Scripture.',
            attributes: [
              'Women\'s Ministry',
              'Practical',
              'Engaging',
              'Scripture',
            ],
          ),
          const Pastor(
            id: '10',
            name: 'Matt Chandler',
            title: 'Lead Pastor',
            imageUrl: 'assets/images/church_avatars/church_avatar_4.png',
            tenure: '2002-Present',
            description:
                'Lead pastor known for his bold preaching and commitment to biblical truth.',
            attributes: ['Bold', 'Biblical', 'Truth', 'Leadership'],
          ),
        ];

        return SeeAllPastorsPage(pastors: pastors);
      },
    ),

    GoRoute(
      path: '/pastor/:pastorId/churches/see-all',
      name: 'see-all-churches-for-pastor',
      builder: (context, state) {
        final pastorId = state.pathParameters['pastorId']!;

        // Create comprehensive mock churches data for the pastor
        final churches = [
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
          const Church(
            id: '4',
            name: 'Reformation Bible Church',
            description:
                'A church dedicated to the doctrines of grace and biblical truth.',
            imageUrl: 'assets/images/church_avatars/church_avatar_4.png',
            distance: 3.2,
            rating: 92.0,
            attributes: ['Reformed', 'Biblical', 'Traditional'],
          ),
          const Church(
            id: '5',
            name: 'Faith Community Church',
            description:
                'A church committed to authentic worship and biblical teaching.',
            imageUrl: 'assets/images/church_avatars/church_avatar_5.png',
            distance: 5.1,
            rating: 89.0,
            attributes: ['Contemporary', 'Community', 'Worship'],
          ),
          const Church(
            id: '6',
            name: 'Calvary Chapel',
            description: 'A church focused on verse-by-verse Bible teaching.',
            imageUrl: 'assets/images/church_avatars/church_avatar_6.png',
            distance: 1.8,
            rating: 87.0,
            attributes: ['Bible Teaching', 'Verse-by-Verse', 'Casual'],
          ),
        ];

        // Get pastor name based on ID (in a real app, you'd fetch this from a service)
        String pastorName = 'John MacArthur';
        switch (pastorId) {
          case '1':
            pastorName = 'John MacArthur';
            break;
          case '2':
            pastorName = 'Mike Riccardi';
            break;
          case '3':
            pastorName = 'Judy Kim';
            break;
          default:
            pastorName = 'Pastor';
        }

        return SeeAllChurchesForPastorPage(
          churches: churches,
          pastorName: pastorName,
        );
      },
    ),

    GoRoute(
      path: '/church/:churchId/sermons/see-all',
      name: 'see-all-church-sermons',
      builder: (context, state) {
        final churchId = state.pathParameters['churchId']!;

        // Create comprehensive mock sermons data for the church
        final sermons = [
          const Sermon(
            id: '1',
            title: 'The Gift of the Gospel',
            pastorName: 'John MacArthur',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_1.png',
            duration: '36:24',
            serviceTime: 'Sunday • 9:30',
          ),
          const Sermon(
            id: '2',
            title: 'Free Will',
            pastorName: 'John MacArthur',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_2.png',
            duration: '46:12',
            serviceTime: 'Sunday • 11:00',
          ),
          const Sermon(
            id: '3',
            title: 'Back to School Summer Camp Devotional',
            pastorName: 'Partner Name',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_3.png',
            duration: '6:24',
            serviceTime: 'Wednesday • 7:00',
          ),
          const Sermon(
            id: '4',
            title: 'Desiring God',
            pastorName: 'John MacArthur',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_4.png',
            duration: '36:24',
            serviceTime: 'Sunday • 9:30',
          ),
          const Sermon(
            id: '5',
            title: 'The Sovereignty of God',
            pastorName: 'John MacArthur',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_5.png',
            duration: '42:18',
            serviceTime: 'Sunday • 11:00',
          ),
          const Sermon(
            id: '6',
            title: 'Walking in Faith',
            pastorName: 'Mike Riccardi',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_6.png',
            duration: '38:45',
            serviceTime: 'Sunday • 9:30',
          ),
          const Sermon(
            id: '7',
            title: 'The Power of Prayer',
            pastorName: 'John MacArthur',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_1.png',
            duration: '44:32',
            serviceTime: 'Sunday • 11:00',
          ),
          const Sermon(
            id: '8',
            title: 'Living for Christ',
            pastorName: 'Judy Kim',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_2.png',
            duration: '35:20',
            serviceTime: 'Wednesday • 7:00',
          ),
        ];

        // Get church name based on ID (in a real app, you'd fetch this from a service)
        String churchName = 'Grace Community Church';
        switch (churchId) {
          case '1':
            churchName = 'Grace Community Church';
            break;
          case '2':
            churchName = 'Immanuel Bible Church';
            break;
          case '3':
            churchName = 'Together for the Gospel';
            break;
          default:
            churchName = 'Church';
        }

        return SeeAllSermonsPage(
          sermons: sermons,
          sourceName: churchName,
          sourceType: 'church',
        );
      },
    ),

    GoRoute(
      path: '/pastor/:pastorId/sermons/see-all',
      name: 'see-all-pastor-sermons',
      builder: (context, state) {
        final pastorId = state.pathParameters['pastorId']!;

        // Create comprehensive mock sermons data for the pastor
        final sermons = [
          const Sermon(
            id: '1',
            title: 'The Gift of the Gospel',
            pastorName: 'John MacArthur',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_1.png',
            duration: '36:24',
            serviceTime: 'Sunday • 9:30',
          ),
          const Sermon(
            id: '2',
            title: 'Free Will',
            pastorName: 'John MacArthur',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_2.png',
            duration: '46:12',
            serviceTime: 'Sunday • 11:00',
          ),
          const Sermon(
            id: '3',
            title: 'Desiring God',
            pastorName: 'John MacArthur',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_3.png',
            duration: '36:24',
            serviceTime: 'Sunday • 9:30',
          ),
          const Sermon(
            id: '4',
            title: 'The Sovereignty of God',
            pastorName: 'John MacArthur',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_4.png',
            duration: '42:18',
            serviceTime: 'Sunday • 11:00',
          ),
          const Sermon(
            id: '5',
            title: 'The Power of Prayer',
            pastorName: 'John MacArthur',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_5.png',
            duration: '44:32',
            serviceTime: 'Sunday • 11:00',
          ),
          const Sermon(
            id: '6',
            title: 'Walking in Faith',
            pastorName: 'John MacArthur',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_6.png',
            duration: '38:45',
            serviceTime: 'Sunday • 9:30',
          ),
          const Sermon(
            id: '7',
            title: 'The Doctrine of Grace',
            pastorName: 'John MacArthur',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_1.png',
            duration: '41:15',
            serviceTime: 'Sunday • 11:00',
          ),
          const Sermon(
            id: '8',
            title: 'Biblical Authority',
            pastorName: 'John MacArthur',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_2.png',
            duration: '39:28',
            serviceTime: 'Wednesday • 7:00',
          ),
          const Sermon(
            id: '9',
            title: 'The Gospel Message',
            pastorName: 'John MacArthur',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_3.png',
            duration: '43:12',
            serviceTime: 'Sunday • 9:30',
          ),
          const Sermon(
            id: '10',
            title: 'Christian Living',
            pastorName: 'John MacArthur',
            thumbnailUrl: 'assets/images/church_avatars/church_avatar_4.png',
            duration: '37:55',
            serviceTime: 'Sunday • 11:00',
          ),
        ];

        // Get pastor name based on ID (in a real app, you'd fetch this from a service)
        String pastorName = 'John MacArthur';
        switch (pastorId) {
          case '1':
            pastorName = 'John MacArthur';
            break;
          case '2':
            pastorName = 'Mike Riccardi';
            break;
          case '3':
            pastorName = 'Judy Kim';
            break;
          default:
            pastorName = 'Pastor';
        }

        return SeeAllSermonsPage(
          sermons: sermons,
          sourceName: pastorName,
          sourceType: 'pastor',
        );
      },
    ),
  ],
);
