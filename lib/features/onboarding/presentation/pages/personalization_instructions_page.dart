import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/personalization_instructions.dart';
import '../providers/personalization_instructions_provider.dart';

class PersonalizationInstructionsPage extends ConsumerStatefulWidget {
  final VoidCallback? onNext;

  const PersonalizationInstructionsPage({super.key, this.onNext});

  @override
  ConsumerState<PersonalizationInstructionsPage> createState() =>
      _PersonalizationInstructionsPageState();
}

class _PersonalizationInstructionsPageState
    extends ConsumerState<PersonalizationInstructionsPage> {
  @override
  Widget build(BuildContext context) {
    final personalizationInstructionsState = ref.watch(
      personalizationInstructionsNotifierProvider,
    );

    if (personalizationInstructionsState.personalizationInstructions.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF121212),
        body: Center(
          child: Text(
            'No personalization instructions found.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final personalizationInstructions =
        personalizationInstructionsState.personalizationInstructions.first;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            // Background blobs (simplified to solid color for now)

            // Main content
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    // Skip button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 150),

                    // Video clips section
                    _buildVideoClipsSection(personalizationInstructions),

                    const SizedBox(height: 24),

                    // Title
                    _buildTitleSection(personalizationInstructions),

                    const Spacer(),

                    // Continue button
                    _buildContinueButton(),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoClipsSection(
    PersonalizationInstructions personalizationInstructions,
  ) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 225,
        child: Stack(
          children: [
            // Left video (behind, smaller, rotated left)
            Positioned(
              top: 25,
              left: 20,
              child: _buildVideoClip(
                width: 100,
                height: 180,
                rotation: -12,
                isMain: false,
                showLikeButton: false,
              ),
            ),
            // Right video (behind, smaller, rotated right)
            Positioned(
              top: 25,
              right: 20,
              child: _buildVideoClip(
                width: 100,
                height: 180,
                rotation: 12,
                isMain: false,
                showLikeButton: personalizationInstructions.showLikeButton,
              ),
            ),
            // Main center video (on top, larger, no rotation)
            Positioned(
              top: 0,
              left: 87, // Centered with slight overlap
              child: _buildVideoClip(
                width: 127,
                height: 225,
                rotation: 0,
                isMain: true,
                showLikeButton: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoClip({
    required double width,
    required double height,
    required double rotation,
    required bool isMain,
    required bool showLikeButton,
  }) {
    return Transform.rotate(
      angle: rotation * 3.14159 / 180,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF232121),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              // Placeholder for video content

              // Gradient overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
              // Like button (only on right video when showLikeButton is true)
              if (showLikeButton)
                Positioned(
                  top: 14,
                  left: 30,
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF04C59),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection(
    PersonalizationInstructions personalizationInstructions,
  ) {
    return Text(
      personalizationInstructions.title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: -0.75,
        height: 1.0,
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          // Use callback if provided, otherwise use default navigation
          if (widget.onNext != null) {
            widget.onNext!();
          } else if (mounted) {
            context.go('/playlist-instructions');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF217B48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48),
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Aktiv Grotesk App',
          ),
        ),
      ),
    );
  }
}
