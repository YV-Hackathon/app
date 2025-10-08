import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import '../../domain/entities/sermon_clip.dart';
import '../../domain/entities/speaker.dart';
import '../providers/sermon_clips_provider.dart';

class SermonClipsPage extends ConsumerStatefulWidget {
  final VoidCallback? onNext;

  const SermonClipsPage({super.key, this.onNext});

  @override
  ConsumerState<SermonClipsPage> createState() => _SermonClipsPageState();
}

class _SermonClipsPageState extends ConsumerState<SermonClipsPage>
    with TickerProviderStateMixin {
  late final CardSwiperController _cardSwiperController;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;
  late final List<SermonClip> _sermonClips;

  bool _isExpanded = false;
  bool _hasTriggeredCompletion =
      false; // Local flag to prevent multiple triggers

  // Video player state
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  int _currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    _sermonClips = _getMockSermonClips();

    // Initialize provider state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sermonClipsProvider.notifier).initialize(_sermonClips.length);
    });

    _cardSwiperController = CardSwiperController();
    _initializeVideo();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_fadeController);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _videoController?.dispose();

    // Only dispose if not already disposed in _handleComplete
    if (!_hasTriggeredCompletion) {
      try {
        _cardSwiperController.dispose();
      } catch (e) {
        print('Controller already disposed: $e');
      }
    }

    super.dispose();
  }

  void _initializeVideo() {
    if (_sermonClips.isNotEmpty) {
      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(_sermonClips[_currentVideoIndex].videoUrl),
      );
      _videoController!.initialize().then((_) {
        if (mounted) {
          setState(() {
            _isVideoInitialized = true;
          });
          _videoController!.play();
        }
      });
    }
  }

  void _loadVideo(int index) {
    if (index < _sermonClips.length) {
      _videoController?.dispose();
      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(_sermonClips[index].videoUrl),
      );
      _videoController!.initialize().then((_) {
        if (mounted) {
          setState(() {
            _isVideoInitialized = true;
            _currentVideoIndex = index;
          });
          _videoController!.play();
        }
      });
    }
  }

  void _handleComplete() {
    // Prevent multiple triggers
    if (_hasTriggeredCompletion || !mounted) return;

    print('🎯 All cards completed');

    // Schedule for after current frame to avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _hasTriggeredCompletion) return;

      // Step 1: Remove CardSwiper from tree by setting flag and rebuilding
      setState(() {
        _hasTriggeredCompletion = true;
      });

      // Step 2: Wait for CardSwiper animation to complete (500ms to be safe)
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return;

        // Now that CardSwiper animation is done, dispose the controller
        try {
          _cardSwiperController.dispose();
          print('🎯 Controller disposed successfully after animation');
        } catch (e) {
          print('🎯 Controller disposal error: $e');
        }

        // Step 3: Navigate to home immediately after disposal
        Future.delayed(const Duration(milliseconds: 50), () {
          if (!mounted) return;
          print('🎯 Navigating to /home');
          context.go('/home');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // If completion triggered, show empty screen (removes CardSwiper from tree)
    // This prevents CardSwiper from continuing to use the disposed controller
    if (_hasTriggeredCompletion) {
      return const SizedBox.shrink(); // Empty, no loading indicator
    }

    // Build the card swiper
    return CardSwiper(
      controller: _cardSwiperController,
      cardsCount: _sermonClips.length,
      onSwipe: (previousIndex, currentIndex, direction) {
        // Early exit if already completed or not mounted
        if (!mounted || _hasTriggeredCompletion) return;

        print(
          'Card $previousIndex swiped to the ${direction.name}. currentIndex: $currentIndex',
        );

        // Update remaining videos count (don't go below 0)
        ref.read(sermonClipsProvider.notifier).decrementRemainingCards();

        // Load new video when swiping (only if there's a next card)
        if (currentIndex != null && currentIndex < _sermonClips.length) {
          _loadVideo(currentIndex);
        }
      },
      onEnd: _handleComplete,
      cardBuilder: (context, index) {
        final sermonClip = _sermonClips[index];
        return _buildSermonClipCard(sermonClip, index);
      },
    );
  }

  Widget _buildSermonClipCard(SermonClip sermonClip, int index) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(color: Color(0xFF121212)),
      child: Stack(
        children: [
          // Main Content - Full Screen
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top + 16,
                  ), // Status bar + padding
                  // App Header
                  _buildAppHeader(),

                  const SizedBox(height: 24),

                  // Video Thumbnail
                  _buildVideoPlayer(sermonClip),

                  const SizedBox(height: 24),

                  // Audio Scrubber
                  _buildAudioScrubber(sermonClip),

                  const SizedBox(height: 24),

                  // Speaker Info
                  _buildSpeakerInfo(sermonClip),

                  const SizedBox(height: 24),

                  // Matching Preferences
                  _buildMatchingPreferences(sermonClip),

                  const SizedBox(height: 24),

                  // Sermon Content
                  _buildSermonContent(sermonClip),

                  const SizedBox(height: 100), // Space for bottom buttons
                ],
              ),
            ),
          ),

          // Bottom Action Buttons
          Positioned(
            bottom: 24,
            left: 8,
            right: 8,
            child: _buildActionButtons(),
          ),
        ],
      ),
    );
  }

  Widget _buildAppHeader() {
    final state = ref.watch(sermonClipsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          // App Logo
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.church, color: Color(0xFF121212), size: 24),
          ),

          const SizedBox(width: 12),

          // App Name
          const Text(
            'App Name',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          // Remaining Videos
          Text(
            '${state.remainingCards} videos remaining',
            style: const TextStyle(
              color: Color(0xFFBFBDBD),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer(SermonClip sermonClip) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 185,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(21)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21),
        child:
            _isVideoInitialized && _videoController != null
                ? Stack(
                  children: [
                    // Video player
                    SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _videoController!.value.size.width,
                          height: _videoController!.value.size.height,
                          child: VideoPlayer(_videoController!),
                        ),
                      ),
                    ),
                    // Play/Pause overlay
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          if (_videoController!.value.isPlaying) {
                            _videoController!.pause();
                          } else {
                            _videoController!.play();
                          }
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _videoController!.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                : Container(
                  color: const Color(0xFF232121),
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
      ),
    );
  }

  Widget _buildAudioScrubber(SermonClip sermonClip) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          // Current time
          Text(
            _formatDuration(sermonClip.currentTime),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(width: 7),

          // Progress bar
          Expanded(
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                color: const Color(0xFF474545),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  // Progress
                  Container(
                    width: 64, // This would be calculated based on progress
                    height: 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  // Handle
                  Positioned(
                    left: 59,
                    top: -5,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 7),

          // Total time
          Text(
            '-${_formatDuration(sermonClip.duration - sermonClip.currentTime)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeakerInfo(SermonClip sermonClip) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF232121),
        borderRadius: BorderRadius.circular(124),
      ),
      child: Row(
        children: [
          // Speaker Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black.withOpacity(0.1),
                width: 0.5,
              ),
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: sermonClip.speaker.imageUrl,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => const CircularProgressIndicator(),
                errorWidget:
                    (context, url, error) =>
                        const Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Speaker Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sermonClip.speaker.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  sermonClip.churchName,
                  style: const TextStyle(
                    color: Color(0xFFBFBDBD),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Chevron
          const Icon(Icons.chevron_right, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  Widget _buildMatchingPreferences(SermonClip sermonClip) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${sermonClip.matchingPreferences} matching preferences',
            style: const TextStyle(
              color: Color(0xFFBFBDBD),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          // Attribute Tags
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              children:
                  sermonClip.attributes.map((attribute) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF217B48)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        attribute,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSermonContent(SermonClip sermonClip) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            sermonClip.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.54,
            ),
          ),

          const SizedBox(height: 8),

          // Description
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Container(
                constraints: BoxConstraints(maxHeight: _isExpanded ? 200 : 96),
                child: Stack(
                  children: [
                    Text(
                      sermonClip.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),

                    if (!_isExpanded)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 68,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Color(0xFF121212)],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),

          if (!_isExpanded)
            GestureDetector(
              onTap: () {
                if (mounted) {
                  setState(() {
                    _isExpanded = true;
                  });
                  _fadeController.forward();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text(
                  'Read More',
                  style: TextStyle(
                    color: Color(0xFFBFBDBD),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        // Skip Button
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (!_hasTriggeredCompletion && mounted) {
                _cardSwiperController.swipeLeft();
              }
            },
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF353333),
                borderRadius: BorderRadius.circular(48),
              ),
              child: const Center(
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Dislike Button (Swipe Left)
        GestureDetector(
          onTap: () {
            if (!_hasTriggeredCompletion && mounted) {
              _cardSwiperController.swipeLeft();
            }
          },
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF353333),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.thumb_down, color: Colors.white, size: 24),
          ),
        ),

        const SizedBox(width: 16),

        // Like Button (Swipe Right)
        GestureDetector(
          onTap: () {
            if (!_hasTriggeredCompletion && mounted) {
              _cardSwiperController.swipeRight();
            }
          },
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFF04C59),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite, color: Colors.white, size: 24),
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  List<SermonClip> _getMockSermonClips() {
    return <SermonClip>[
      SermonClip(
        id: '1',
        title: 'The Gift of the Gospel',
        videoUrl:
            'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=300&fit=crop',
        description:
            'In this message, Pastor John McArthur explores how the good news of Jesus is more than a story from the past—it\'s a present reality that transforms our lives today. Through Scripture and practical examples, he unpacks the depth of God\'s grace, the power of forgiveness, and the hope that comes from living in the freedom Christ offers.',
        speaker: const Speaker(
          id: '1',
          name: 'John McArthur',
          imageUrl:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
        ),
        churchName: 'Grace Community Church',
        churchLogo:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop',
        duration: const Duration(minutes: 1, seconds: 20),
        currentTime: const Duration(seconds: 12),
        publishedAt: DateTime.now().subtract(const Duration(days: 2)),
        viewCount: 15420,
        likeCount: 892,
        attributes: ['Attribute', 'Attribute', 'Attribute'],
        matchingPreferences: 3,
      ),
      SermonClip(
        id: '2',
        title: 'Walking in Faith',
        videoUrl:
            'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_2mb.mp4',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&h=300&fit=crop',
        description:
            'Discover the transformative power of faith and how it can change your life completely. This message explores the depth of God\'s love and the hope that comes from living in His grace.',
        speaker: const Speaker(
          id: '2',
          name: 'Craig Groeschel',
          imageUrl:
              'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        ),
        churchName: 'Life.Church',
        churchLogo:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop',
        duration: const Duration(minutes: 1, seconds: 45),
        currentTime: const Duration(seconds: 30),
        publishedAt: DateTime.now().subtract(const Duration(days: 5)),
        viewCount: 28930,
        likeCount: 1245,
        attributes: ['Faith', 'Hope', 'Grace'],
        matchingPreferences: 2,
      ),
      SermonClip(
        id: '3',
        title: 'The Love of God',
        videoUrl:
            'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_5mb.mp4',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&h=300&fit=crop',
        description:
            'Experience the overwhelming love of God that transforms hearts and changes lives. God\'s love is unconditional, unfailing, and everlasting.',
        speaker: const Speaker(
          id: '3',
          name: 'John Piper',
          imageUrl:
              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
        ),
        churchName: 'Bethlehem Baptist Church',
        churchLogo:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&h=100&fit=crop',
        duration: const Duration(minutes: 2, seconds: 15),
        currentTime: const Duration(seconds: 45),
        publishedAt: DateTime.now().subtract(const Duration(days: 1)),
        viewCount: 45670,
        likeCount: 2103,
        attributes: ['Love', 'Grace', 'Redemption'],
        matchingPreferences: 4,
      ),
      SermonClip(
        id: '4',
        title: 'Purpose and Calling',
        videoUrl:
            'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_3mb.mp4',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400&h=300&fit=crop',
        description:
            'Discover your God-given purpose and learn how to walk in it with confidence. Every person has a unique calling and destiny that God has prepared for them.',
        speaker: const Speaker(
          id: '4',
          name: 'Christine Caine',
          imageUrl:
              'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
        ),
        churchName: 'Hillsong Church',
        churchLogo:
            'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100&h=100&fit=crop',
        duration: const Duration(minutes: 1, seconds: 30),
        currentTime: const Duration(seconds: 20),
        publishedAt: DateTime.now().subtract(const Duration(days: 3)),
        viewCount: 32150,
        likeCount: 1567,
        attributes: ['Purpose', 'Calling', 'Destiny'],
        matchingPreferences: 3,
      ),
      SermonClip(
        id: '5',
        title: 'The Power of Prayer',
        videoUrl:
            'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_4mb.mp4',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400&h=300&fit=crop',
        description:
            'Learn about the transformative power of prayer and how it can change your life and the lives of those around you. Prayer is not just asking for things, but building a relationship with God.',
        speaker: const Speaker(
          id: '5',
          name: 'Timothy Keller',
          imageUrl:
              'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&h=150&fit=crop&crop=face',
        ),
        churchName: 'Redeemer Presbyterian',
        churchLogo:
            'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100&h=100&fit=crop',
        duration: const Duration(minutes: 1, seconds: 55),
        currentTime: const Duration(seconds: 35),
        publishedAt: DateTime.now().subtract(const Duration(days: 4)),
        viewCount: 28750,
        likeCount: 1342,
        attributes: ['Prayer', 'Relationship', 'Faith'],
        matchingPreferences: 2,
      ),
    ];
  }
}
