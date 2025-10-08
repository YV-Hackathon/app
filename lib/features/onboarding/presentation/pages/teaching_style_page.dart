import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/teaching_style_state.dart';
import '../../domain/entities/teaching_style.dart';
import '../providers/teaching_style_provider.dart';

class TeachingStylePage extends ConsumerStatefulWidget {
  final VoidCallback? onNext;

  const TeachingStylePage({super.key, this.onNext});

  @override
  ConsumerState<TeachingStylePage> createState() => _TeachingStylePageState();
}

class _TeachingStylePageState extends ConsumerState<TeachingStylePage> {
  @override
  Widget build(BuildContext context) {
    final teachingStyleState = ref.watch(teachingStyleNotifierProvider);
    final teachingStyleNotifier = ref.read(
      teachingStyleNotifierProvider.notifier,
    );

    if (teachingStyleState.teachingStyles.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF121212),
        body: Center(
          child: Text(
            'No teaching styles found.',
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

              // Teaching style options
              Expanded(
                child: _buildTeachingStyleOptions(
                  teachingStyleState,
                  teachingStyleNotifier,
                ),
              ),

              const SizedBox(height: 24),

              // Continue button
              _buildContinueButton(teachingStyleState, teachingStyleNotifier),

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
                    color: index < 3 ? Colors.white : const Color(0xFF353333),
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
          'What style of teaching do you connect with most?',
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

  Widget _buildTeachingStyleOptions(
    TeachingStyleState state,
    TeachingStyleNotifier notifier,
  ) {
    return ListView.builder(
      itemCount: state.teachingStyles.length,
      itemBuilder: (context, index) {
        final teachingStyle = state.teachingStyles[index];
        final isSelected = state.selectedTeachingStyleId == teachingStyle.id;

        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _buildTeachingStyleCard(
            teachingStyle: teachingStyle,
            isSelected: isSelected,
            onTap: () => notifier.selectTeachingStyle(teachingStyle.id),
          ),
        );
      },
    );
  }

  Widget _buildTeachingStyleCard({
    required TeachingStyle teachingStyle,
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
                    teachingStyle.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    teachingStyle.description,
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
    TeachingStyleState state,
    TeachingStyleNotifier notifier,
  ) {
    final hasSelection = notifier.hasSelectedTeachingStyle;

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
                    context.go('/church-environment');
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
