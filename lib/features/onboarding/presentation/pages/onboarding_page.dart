import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/onboarding_state.dart';
import '../../domain/entities/speaker.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/speaker_card.dart';
import '../widgets/progress_bar.dart';
import '../widgets/onboarding_button.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingNotifierProvider);
    final notifier = ref.read(onboardingNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF121212),
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Speakers grid - extends all the way to bottom
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),

                    // Progress bar and skip
                    ProgressBar(
                      currentStep: onboardingState.currentStep,
                      totalSteps: 4,
                      onSkip: () => notifier.skipOnboarding(),
                    ),

                    const SizedBox(height: 70),

                    // Description section
                    _buildDescriptionSection(),

                    const SizedBox(height: 24),

                    // Speakers grid - extends to bottom of screen
                    Expanded(
                      child: _buildSpeakersGrid(onboardingState, notifier),
                    ),
                  ],
                ),
              ),

              // Continue button positioned at bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  child: OnboardingButton(
                    text: 'Continue',
                    onPressed:
                        onboardingState.selectedSpeakerIds.isNotEmpty
                            ? () => notifier.nextStep()
                            : null,
                    isPrimary: onboardingState.selectedSpeakerIds.isNotEmpty,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Find a Church',
          style: TextStyle(
            fontFamily: 'Aktiv Grotesk App',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFFBFBDBD),
            height: 1.25,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Select speakers that interest you.',
          style: TextStyle(
            fontFamily: 'Aktiv Grotesk App',
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
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3BC175)),
        ),
      );
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              'Error loading speakers',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.error!,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Group speakers into rows of 3
    final speakers = state.speakers;
    final rows = <List<Speaker>>[];

    for (int i = 0; i < speakers.length; i += 3) {
      final end = (i + 3 < speakers.length) ? i + 3 : speakers.length;
      rows.add(speakers.sublist(i, end));
    }

    return ListView.builder(
      itemCount: rows.length,
      itemBuilder: (context, rowIndex) {
        final row = rows[rowIndex];
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            children: List.generate(3, (colIndex) {
              if (colIndex < row.length) {
                final currentSpeaker = row[colIndex];
                final speaker = currentSpeaker.copyWith(
                  isSelected: state.selectedSpeakerIds.contains(
                    currentSpeaker.id,
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
                        // Speaker card centered in the reserved space
                        SpeakerCard(
                          speaker: speaker,
                          onTap:
                              () => notifier.toggleSpeakerSelection(
                                currentSpeaker.id,
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
}
