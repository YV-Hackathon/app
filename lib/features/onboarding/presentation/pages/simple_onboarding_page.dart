import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/speaker.dart';
import '../providers/specific_question_providers.dart';
import '../providers/question_provider.dart';
import '../providers/onboarding_submission_provider.dart';
import '../widgets/speaker_card.dart';

class SimpleOnboardingPage extends ConsumerStatefulWidget {
  final VoidCallback? onNext;

  const SimpleOnboardingPage({super.key, this.onNext});

  @override
  ConsumerState<SimpleOnboardingPage> createState() =>
      _SimpleOnboardingPageState();
}

class _SimpleOnboardingPageState extends ConsumerState<SimpleOnboardingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final speakers = ref.watch(speakersProvider);
    final isLoading = ref.watch(questionsLoadingProvider);
    final error = ref.watch(questionsErrorProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content with no bottom padding to allow grid to extend
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),

                  // Progress bar
                  _buildProgressBar(),

                  const SizedBox(height: 70),

                  // Description section
                  _buildDescriptionSection(),

                  const SizedBox(height: 24),

                  // Speakers grid - extends all the way to bottom
                  Expanded(
                    child: _buildSpeakersGrid(speakers, isLoading, error),
                  ),
                ],
              ),
            ),

            // Black gradient overlay behind button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50, // Shorter gradient overlay
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black38,
                      Colors.black87,
                    ],
                    stops: [0.0, 0.4, 1.0],
                  ),
                ),
              ),
            ),

            // Continue button positioned at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(24.0),
                child: _buildContinueButton(speakers),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: List.generate(5, (index) {
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: index < 4 ? 16 : 0),
                  decoration: BoxDecoration(
                    color: Colors.white, // All 5 steps completed
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 24),
        const Text(
          'Skip',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Find a Church',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFFBFBDBD),
            height: 1.25,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Select speakers that interest you.',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.75,
            height: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildSpeakersGrid(
    List<Speaker> speakers,
    bool isLoading,
    String? error,
  ) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $error', style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  () => ref.read(questionNotifierProvider.notifier).retry(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (speakers.isEmpty) {
      return const Center(
        child: Text(
          'No speakers found.',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    // Group speakers into rows of 3
    final List<List<Speaker>> rows = [];
    for (int i = 0; i < speakers.length; i += 3) {
      rows.add(
        speakers.sublist(i, i + 3 > speakers.length ? speakers.length : i + 3),
      );
    }

    return ListView.builder(
      itemCount: rows.length,
      itemBuilder: (context, rowIndex) {
        final row = rows[rowIndex];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: List.generate(3, (colIndex) {
              if (colIndex < row.length) {
                final speaker = row[colIndex];

                // Calculate staggered delay based on position in grid
                // Creates diagonal wave effect from top-left to bottom-right
                final cardIndex = (rowIndex * 3) + colIndex;
                final delay = cardIndex * 0.08;
                final start = delay.clamp(0.0, 1.0);
                final end = (delay + 0.4).clamp(0.0, 1.0);

                final fadeAnimation = Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Interval(start, end, curve: Curves.easeOut),
                  ),
                );

                final scaleAnimation = Tween<double>(
                  begin: 0.7,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Interval(start, end, curve: Curves.easeOut),
                  ),
                );

                return Expanded(
                  child: SizedBox(
                    height:
                        140, // Extra space to accommodate largest speaker card (101px + border + text + spacing)
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Invisible placeholder to maintain consistent positioning
                        Container(
                          width: 101, // Always reserve space for largest card
                          height: 101,
                        ),
                        // Speaker card centered in the reserved space with animation
                        FadeTransition(
                          opacity: fadeAnimation,
                          child: ScaleTransition(
                            scale: scaleAnimation,
                            child: SpeakerCard(
                              speaker: speaker,
                              onTap:
                                  () => ref
                                      .read(questionNotifierProvider.notifier)
                                      .toggleSpeaker(speaker.id),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Expanded(child: SizedBox());
              }
            }),
          ),
        );
      },
    );
  }

  Widget _buildContinueButton(List<Speaker> speakers) {
    final hasSelection = speakers.any((s) => s.isSelected);

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed:
            hasSelection
                ? () async {
                  // Submit onboarding with selected speakers
                  print(
                    '🚀 Triggering onboarding submission from speakers page...',
                  );
                  await ref
                      .read(onboardingSubmissionNotifierProvider.notifier)
                      .submitOnboarding();

                  print('✅ Onboarding submission completed, navigating...');

                  // Navigate after submission completes
                  if (widget.onNext != null) {
                    widget.onNext!();
                  } else if (mounted) {
                    context.go('/personalization-intro');
                  }
                }
                : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              hasSelection ? const Color(0xFF217B48) : const Color(0xFF232121),
          disabledBackgroundColor: const Color(0xFF232121),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48),
          ),
        ),
        child: Text(
          'Continue',
          style: TextStyle(
            color: hasSelection ? Colors.white : const Color(0xFF909090),
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Aktiv Grotesk App',
          ),
        ),
      ),
    );
  }
}
