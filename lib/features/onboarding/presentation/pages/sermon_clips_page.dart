import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import '../../domain/entities/sermon_clip.dart';
import '../providers/sermon_clips_provider.dart';
import '../providers/onboarding_submission_provider.dart';
import '../providers/sermon_preference_provider.dart';
import '../../data/models/onboarding_submission_response.dart';
import '../../data/models/recommended_sermon_mapper.dart';
import '../../data/models/sermon_preference_request.dart';
import '../../../churches/domain/entities/church.dart';
import '../../../churches/presentation/pages/church_profile_page.dart';

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
  final List<SermonClip> _sermonClips = [];

  bool _isExpanded = false;
  bool _hasTriggeredCompletion =
      false; // Local flag to prevent multiple triggers

  // Video player state
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  int _currentVideoIndex = 0;
  bool _showPlayPauseIcon = false;
  Timer? _iconTimer;
  bool _isLoadingVideo = false;

  late AnimationController _pageEntranceController;
  late Animation<double> _pageEntranceFade;
  late Animation<Offset> _pageEntranceSlide;

  @override
  void initState() {
    super.initState();

    _cardSwiperController = CardSwiperController();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_fadeController);

    // Page entrance animation
    _pageEntranceController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pageEntranceFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pageEntranceController, curve: Curves.easeOut),
    );

    _pageEntranceSlide = Tween<Offset>(
      begin: const Offset(0, 0.03),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _pageEntranceController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pageEntranceController.dispose();
    _videoController?.removeListener(_videoListener);
    _videoController?.dispose();
    _iconTimer?.cancel();

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

  void _showIconTemporarily({required bool isPlaying}) {
    // Cancel any existing timer
    _iconTimer?.cancel();

    // Show the icon
    setState(() {
      _showPlayPauseIcon = true;
    });

    // If playing, hide the pause icon after 2 seconds
    // If paused, keep the play icon visible
    if (isPlaying) {
      _iconTimer = Timer(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _showPlayPauseIcon = false;
          });
        }
      });
    }
    // If paused, icon stays visible (no timer)
  }

  void _initializeVideo() {
    if (_sermonClips.isNotEmpty) {
      setState(() {
        _isLoadingVideo = true;
      });

      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(_sermonClips[_currentVideoIndex].videoUrl),
      );
      _videoController!
          .initialize()
          .then((_) {
            if (mounted) {
              setState(() {
                _isVideoInitialized = true;
                _isLoadingVideo = false;
              });
              // Listen to video position updates
              _videoController!.addListener(_videoListener);
              _videoController!.play();
              // Show pause icon briefly when video starts playing
              _showIconTemporarily(isPlaying: true);
            }
          })
          .catchError((error) {
            // Handle video loading error
            if (mounted) {
              setState(() {
                _isLoadingVideo = false;
              });
            }
            print('Error initializing video: $error');
          });
    }
  }

  void _videoListener() {
    // Update UI when video position changes
    if (mounted && _videoController != null) {
      setState(() {});
    }
  }

  void _loadVideo(int index) {
    if (index < _sermonClips.length) {
      // Set loading state
      setState(() {
        _isLoadingVideo = true;
        _isVideoInitialized = false;
      });

      // Remove listener from old controller before disposing
      _videoController?.removeListener(_videoListener);
      _videoController?.dispose();

      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(_sermonClips[index].videoUrl),
      );
      _videoController!
          .initialize()
          .then((_) {
            if (mounted) {
              setState(() {
                _isVideoInitialized = true;
                _currentVideoIndex = index;
                _isLoadingVideo = false;
              });
              // Listen to video position updates
              _videoController!.addListener(_videoListener);
              _videoController!.play();
              // Show pause icon briefly when new video starts playing
              _showIconTemporarily(isPlaying: true);
            }
          })
          .catchError((error) {
            // Handle video loading error
            if (mounted) {
              setState(() {
                _isLoadingVideo = false;
              });
            }
            print('Error loading video: $error');
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

        // Step 3: Navigate to success screen immediately after disposal
        Future.delayed(const Duration(milliseconds: 50), () {
          if (!mounted) return;
          print('🎯 Navigating to success screen');
          context.go('/onboarding-success');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get recommended sermons from onboarding submission
    final recommendedSermons = ref.watch(recommendedSermonsProvider);
    final submissionState = ref.watch(onboardingSubmissionNotifierProvider);

    print(
      '🎬 ==================== SERMON CLIPS PAGE BUILD ====================',
    );
    print('📊 Submission status: ${submissionState.status}');
    print('📦 Response object exists: ${submissionState.response != null}');
    if (submissionState.response != null) {
      print(
        '📦 Response recommendedSermons exists: ${submissionState.response!.recommendedSermons != null}',
      );
      print(
        '📦 Response recommendedSermons count: ${submissionState.response!.recommendedSermons?.length ?? 0}',
      );
    }
    print('📊 Recommended sermons from provider: ${recommendedSermons.length}');

    if (recommendedSermons.isNotEmpty) {
      print('✅ Found ${recommendedSermons.length} sermons from provider:');
      for (var i = 0; i < recommendedSermons.length; i++) {
        final sermon = recommendedSermons[i];
        print('  [$i] ${sermon.title}');
        print('      ID: ${sermon.id}');
        print('      Speaker: ${sermon.speaker?.name ?? "No speaker"}');
        print('      GCS URL: ${sermon.gcsUrl}');
        print('      Description: ${sermon.description}');
        print('      Is Clip: ${sermon.isClip ?? false}');
      }
    } else {
      print('⚠️ WARNING: No sermons found in provider!');
      print('   This means recommendedSermonsProvider returned empty list');
    }
    print(
      '🎬 ================================================================',
    );

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: _buildBodyFromSubmission(
        recommendedSermons,
        submissionState.status,
      ),
    );
  }

  Widget _buildBodyFromSubmission(
    List<RecommendedSermon> recommendedSermons,
    SubmissionStatus status,
  ) {
    // Show loading if submission is still in progress
    if (status == SubmissionStatus.submitting) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF3BC175)),
      );
    }

    // Show error if submission failed
    if (status == SubmissionStatus.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Error loading recommendations',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Failed to get sermon recommendations',
              style: TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(onboardingSubmissionNotifierProvider.notifier).reset();
                context.go('/onboarding');
              },
              child: const Text('Restart Onboarding'),
            ),
          ],
        ),
      );
    }

    // Convert recommended sermons to sermon clips
    print(
      '🔄 Converting ${recommendedSermons.length} recommended sermons to clips...',
    );

    final sermonClips = recommendedSermons.toSermonClips();

    print('🎥 Total sermon clips after conversion: ${sermonClips.length}');
    for (var i = 0; i < sermonClips.length; i++) {
      print('  - Sermon $i: ${sermonClips[i].title}');
      print('    👤 Speaker: ${sermonClips[i].speaker.name}');
      print('    ⛪ Church: ${sermonClips[i].churchName}');
      print('    🖼️ Church Logo: ${sermonClips[i].churchLogo}');
    }

    // If no sermon clips available
    print('❓ Checking if sermonClips is empty: ${sermonClips.isEmpty}');
    if (sermonClips.isEmpty) {
      print('⚠️ SHOWING NO SERMONS SCREEN - sermonClips is empty!');
      print('   Status: $status');
      print('   Recommended sermons count: ${recommendedSermons.length}');
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.movie_filter_outlined,
              color: Colors.grey,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'No sermon recommendations available',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please complete onboarding to get personalized recommendations',
              style: TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.go('/onboarding');
              },
              child: const Text('Go to Onboarding'),
            ),
          ],
        ),
      );
    }

    // Update local sermon clips if they changed
    if (_sermonClips.isEmpty || _sermonClips.length != sermonClips.length) {
      print(
        '🔄 Updating local _sermonClips from ${_sermonClips.length} to ${sermonClips.length}',
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _sermonClips.clear();
            _sermonClips.addAll(sermonClips);
          });
          ref.read(sermonClipsProvider.notifier).initialize(sermonClips.length);
          _initializeVideo();
          // Start the page entrance animation
          _pageEntranceController.forward();
          print('✅ Local _sermonClips updated successfully');
        }
      });

      // Important: Return loading indicator while we wait for the callback to update _sermonClips
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF3BC175)),
      );
    }

    return _buildBody();
  }

  Widget _buildBody() {
    print('🏗️ Building body with ${_sermonClips.length} sermon clips');

    // If completion triggered, show empty screen (removes CardSwiper from tree)
    // This prevents CardSwiper from continuing to use the disposed controller
    if (_hasTriggeredCompletion) {
      return const SizedBox.shrink(); // Empty, no loading indicator
    }

    // If sermon clips not loaded yet (this should not happen now)
    if (_sermonClips.isEmpty) {
      print('⚠️ _sermonClips is empty in _buildBody!');
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF3BC175)),
      );
    }

    // Build the card swiper with entrance animation
    return FadeTransition(
      opacity: _pageEntranceFade,
      child: SlideTransition(
        position: _pageEntranceSlide,
        child: CardSwiper(
          controller: _cardSwiperController,
          cardsCount: _sermonClips.length,
          onSwipe: (previousIndex, currentIndex, direction) {
            // Early exit if already completed or not mounted
            if (!mounted || _hasTriggeredCompletion || previousIndex == null)
              return;

            print(
              'Card $previousIndex swiped to the ${direction.name}. currentIndex: $currentIndex',
            );

            // Submit preference based on swipe direction
            final swipedSermon = _sermonClips[previousIndex];
            final preference =
                direction.name == 'right'
                    ? SermonPreference.thumbsUp
                    : SermonPreference.thumbsDown;

            // Parse sermon ID safely
            final sermonId = int.tryParse(swipedSermon.id);
            if (sermonId != null) {
              ref
                  .read(sermonPreferenceNotifierProvider.notifier)
                  .submitPreference(
                    userId: 6,
                    sermonId: sermonId,
                    preference: preference,
                  );
            }

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
        ),
      ),
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

          // App Name
          const Text(
            'PewPal',
            style: TextStyle(
              color: Color(0xFF3BC076),
              fontSize: 20,
              fontWeight: FontWeight.w700,
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
            _isVideoInitialized && _videoController != null && !_isLoadingVideo
                ? GestureDetector(
                  onTap: () {
                    final wasPlaying = _videoController!.value.isPlaying;
                    setState(() {
                      if (wasPlaying) {
                        _videoController!.pause();
                      } else {
                        _videoController!.play();
                      }
                    });
                    // Pass the NEW state (opposite of what it was)
                    _showIconTemporarily(isPlaying: !wasPlaying);
                  },
                  child: Stack(
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
                      // Loading overlay when transitioning
                      if (_isLoadingVideo)
                        Container(
                          color: const Color(0xFF232121),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF3BC175),
                            ),
                          ),
                        ),
                      // Play/Pause overlay - only show temporarily
                      if (_showPlayPauseIcon && !_isLoadingVideo)
                        Center(
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
                    ],
                  ),
                )
                : Container(
                  color: const Color(0xFF232121),
                  child: const Center(
                    child: CircularProgressIndicator(color: Color(0xFF3BC175)),
                  ),
                ),
      ),
    );
  }

  Widget _buildAudioScrubber(SermonClip sermonClip) {
    // Get real-time video position and duration
    final position = _videoController?.value.position ?? Duration.zero;
    final duration = _videoController?.value.duration ?? Duration.zero;
    final remaining = duration - position;

    // Calculate progress percentage
    final progress =
        duration.inMilliseconds > 0
            ? (position.inMilliseconds / duration.inMilliseconds).clamp(
              0.0,
              1.0,
            )
            : 0.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          // Current time
          Text(
            _formatDuration(position),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(width: 7),

          // Progress bar
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final progressWidth = constraints.maxWidth * progress;
                final handlePosition = (progressWidth - 6).clamp(
                  0.0,
                  constraints.maxWidth - 12,
                );

                return Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: const Color(0xFF474545),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      // Progress
                      Container(
                        width: progressWidth,
                        height: 2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      // Handle
                      Positioned(
                        left: handlePosition,
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
                );
              },
            ),
          ),

          const SizedBox(width: 7),

          // Time remaining
          Text(
            '-${_formatDuration(remaining)}',
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
    return GestureDetector(
      onTap: () => _navigateToPastorProfile(sermonClip),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF232121),
          borderRadius: BorderRadius.circular(124),
        ),
        child: Row(
          children: [
            // Church Profile Image
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF217B48),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child:
                    sermonClip.churchLogo.isNotEmpty
                        ? Image.network(
                          sermonClip.churchLogo,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => const Icon(
                                Icons.church,
                                color: Colors.white,
                                size: 24,
                              ),
                        )
                        : const Icon(
                          Icons.church,
                          color: Colors.white,
                          size: 24,
                        ),
              ),
            ),

            const SizedBox(width: 12),

            // Church and Speaker Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sermonClip.churchName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sermonClip.speaker.name,
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
      ),
    );
  }

  void _navigateToPastorProfile(SermonClip sermonClip) {
    print('🏛️ Navigating to church profile for: ${sermonClip.churchName}');

    // Pause the video before navigating
    if (_videoController != null && _videoController!.value.isPlaying) {
      _videoController!.pause();
      setState(() {
        _showPlayPauseIcon =
            true; // Show the play icon since video is now paused
      });
    }

    // Get the current sermon's recommended data
    final recommendedSermons = ref.read(recommendedSermonsProvider);
    print('📊 Total recommended sermons: ${recommendedSermons.length}');

    // Find the matching recommended sermon to get full church details
    final currentSermon = recommendedSermons.firstWhere(
      (sermon) => sermon.id.toString() == sermonClip.id,
      orElse: () => recommendedSermons.first,
    );

    print('🎯 Found sermon: ${currentSermon.title}');
    print('👤 Speaker: ${currentSermon.speaker?.name}');
    print('⛪ Church: ${currentSermon.speaker?.church?.name}');

    if (currentSermon.speaker?.church == null) {
      print('⚠️ No church data available for this sermon');
      return;
    }

    final churchData = currentSermon.speaker!.church!;

    // Create Church object from church data
    final church = Church(
      id: churchData.id.toString(),
      name: churchData.name,
      description: churchData.description ?? 'No description available',
      imageUrl: churchData.imageUrl ?? '',
      distance: -1, // Online - we don't have distance data
      rating: 0, // We don't have rating data from API
      attributes: _buildChurchAttributes(currentSermon.speaker!),
      isOnline: true,
    );

    print('✅ Navigating to church: ${church.name} (ID: ${church.id})');

    // Navigate to church profile page
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChurchProfilePage(church: church),
      ),
    );
  }

  List<String> _buildChurchAttributes(RecommendedSpeaker speaker) {
    final attributes = <String>[];

    if (speaker.teachingStyle != null) {
      attributes.add(_formatEnumValue(speaker.teachingStyle!));
    }
    if (speaker.bibleApproach != null) {
      attributes.add(_formatEnumValue(speaker.bibleApproach!));
    }
    if (speaker.environmentStyle != null) {
      attributes.add(_formatEnumValue(speaker.environmentStyle!));
    }

    return attributes;
  }

  String _formatEnumValue(String value) {
    return value
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
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
              runSpacing: 8,
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
                // Submit thumbs_down preference for skip
                final currentSermon = _sermonClips[_currentVideoIndex];
                final sermonId = int.tryParse(currentSermon.id);
                if (sermonId != null) {
                  ref
                      .read(sermonPreferenceNotifierProvider.notifier)
                      .submitPreference(
                        userId: 6,
                        sermonId: sermonId,
                        preference: SermonPreference.thumbsDown,
                      );
                }

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
              // Submit thumbs_down preference
              final currentSermon = _sermonClips[_currentVideoIndex];
              final sermonId = int.tryParse(currentSermon.id);
              if (sermonId != null) {
                ref
                    .read(sermonPreferenceNotifierProvider.notifier)
                    .submitPreference(
                      userId: 6,
                      sermonId: sermonId,
                      preference: SermonPreference.thumbsDown,
                    );
              }

              _cardSwiperController.swipeLeft();
            }
          },
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEBEB),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, color: Colors.black, size: 24),
          ),
        ),

        const SizedBox(width: 16),

        // Like Button (Swipe Right)
        GestureDetector(
          onTap: () {
            if (!_hasTriggeredCompletion && mounted) {
              // Submit thumbs_up preference
              final currentSermon = _sermonClips[_currentVideoIndex];
              final sermonId = int.tryParse(currentSermon.id);
              if (sermonId != null) {
                ref
                    .read(sermonPreferenceNotifierProvider.notifier)
                    .submitPreference(
                      userId: 6,
                      sermonId: sermonId,
                      preference: SermonPreference.thumbsUp,
                    );
              }

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
            child: const Icon(
              Icons.favorite_border_outlined,
              color: Colors.white,
              size: 24,
            ),
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
}
