import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/church_environment_state.dart';
import '../../domain/entities/church_environment.dart';
import '../providers/church_environment_provider.dart';

class ChurchEnvironmentPage extends ConsumerStatefulWidget {
  final VoidCallback? onNext;

  const ChurchEnvironmentPage({super.key, this.onNext});

  @override
  ConsumerState<ChurchEnvironmentPage> createState() =>
      _ChurchEnvironmentPageState();
}

class _ChurchEnvironmentPageState extends ConsumerState<ChurchEnvironmentPage> {
  @override
  Widget build(BuildContext context) {
    final churchEnvironmentState = ref.watch(churchEnvironmentNotifierProvider);
    final churchEnvironmentNotifier = ref.read(
      churchEnvironmentNotifierProvider.notifier,
    );

    if (churchEnvironmentState.churchEnvironments.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF121212),
        body: Center(
          child: Text(
            'No church environments found.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
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

              // Church environment options
              Expanded(
                child: _buildChurchEnvironmentOptions(
                  churchEnvironmentState,
                  churchEnvironmentNotifier,
                ),
              ),

              const SizedBox(height: 24),

              // Continue button
              _buildContinueButton(
                churchEnvironmentState,
                churchEnvironmentNotifier,
              ),

              const SizedBox(height: 16),
            ],
          ),
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
                    color: Colors.white, // All 4 steps completed
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
          'What kind of environment are you hoping to find?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.72,
            height: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildChurchEnvironmentOptions(
    ChurchEnvironmentState state,
    ChurchEnvironmentNotifier notifier,
  ) {
    return ListView.builder(
      itemCount: state.churchEnvironments.length,
      itemBuilder: (context, index) {
        final churchEnvironment = state.churchEnvironments[index];
        final isSelected =
            state.selectedChurchEnvironmentId == churchEnvironment.id;

        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _buildChurchEnvironmentCard(
            churchEnvironment: churchEnvironment,
            isSelected: isSelected,
            onTap: () => notifier.selectChurchEnvironment(churchEnvironment.id),
          ),
        );
      },
    );
  }

  Widget _buildChurchEnvironmentCard({
    required ChurchEnvironment churchEnvironment,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF232121),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    churchEnvironment.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    churchEnvironment.description,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFFBFBDBD),
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 32),
            _buildRadioButton(isSelected),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButton(bool isSelected) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(
          color:
              isSelected
                  ? const Color(0xFF3BC175)
                  : Colors.white.withOpacity(0.38),
          width: 2,
        ),
      ),
      child:
          isSelected
              ? Center(
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF3BC175),
                  ),
                ),
              )
              : null,
    );
  }

  Widget _buildContinueButton(
    ChurchEnvironmentState state,
    ChurchEnvironmentNotifier notifier,
  ) {
    final hasSelection = notifier.hasSelectedChurchEnvironment;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed:
            hasSelection
                ? () {
                  // Use callback if provided, otherwise use default navigation
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
