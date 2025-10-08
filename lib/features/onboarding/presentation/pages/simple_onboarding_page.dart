import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/onboarding_state.dart';
import '../../domain/entities/speaker.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/speaker_card.dart';

class SimpleOnboardingPage extends ConsumerStatefulWidget {
  final VoidCallback? onNext;

  const SimpleOnboardingPage({super.key, this.onNext});

  @override
  ConsumerState<SimpleOnboardingPage> createState() =>
      _SimpleOnboardingPageState();
}

class _SimpleOnboardingPageState extends ConsumerState<SimpleOnboardingPage> {
  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingNotifierProvider);
    final notifier = ref.read(onboardingNotifierProvider.notifier);

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
                    child: _buildSpeakersGrid(onboardingState, notifier),
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
                child: _buildContinueButton(onboardingState, notifier),
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
            children: List.generate(4, (index) {
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: index < 3 ? 16 : 0),
                  decoration: BoxDecoration(
                    color: index == 0 ? Colors.white : const Color(0xFF353333),
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
    OnboardingState state,
    OnboardingNotifier notifier,
  ) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (state.error != null) {
      return Center(
        child: Text(
          'Error: ${state.error}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (state.speakers.isEmpty) {
      return const Center(
        child: Text(
          'No speakers found.',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    // Use speakers from the provider
    final speakers = state.speakers;

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
                final isSelected = state.selectedSpeakerIds.contains(
                  speaker.id,
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
                        // Speaker card centered in the reserved space
                        SpeakerCard(
                          speaker: speaker.copyWith(isSelected: isSelected),
                          onTap:
                              () => notifier.toggleSpeakerSelection(speaker.id),
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

  Widget _buildContinueButton(
    OnboardingState state,
    OnboardingNotifier notifier,
  ) {
    final hasSelection = state.selectedSpeakerIds.isNotEmpty;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed:
            hasSelection
                ? () {
                  notifier.nextStep();
                  // Use callback if provided, otherwise use default navigation
                  if (widget.onNext != null) {
                    widget.onNext!();
                  } else if (mounted) {
                    context.go('/question');
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
