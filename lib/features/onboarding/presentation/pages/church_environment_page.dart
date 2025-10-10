import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/question_option.dart';
import '../providers/specific_question_providers.dart';
import '../providers/question_provider.dart';

class ChurchEnvironmentPage extends ConsumerStatefulWidget {
  final VoidCallback? onNext;

  const ChurchEnvironmentPage({super.key, this.onNext});

  @override
  ConsumerState<ChurchEnvironmentPage> createState() =>
      _ChurchEnvironmentPageState();
}

class _ChurchEnvironmentPageState extends ConsumerState<ChurchEnvironmentPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1600),
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
    final question = ref.watch(environmentQuestionProvider);
    final isLoading = ref.watch(questionsLoadingProvider);
    final error = ref.watch(questionsErrorProvider);
    final questionNotifier = ref.read(questionNotifierProvider.notifier);

    // Handle loading state
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF121212),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF217B48)),
        ),
      );
    }

    // Handle error state
    if (error != null) {
      return Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error: $error',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => questionNotifier.retry(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF217B48),
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    // Handle empty state
    if (question == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF121212),
        body: Center(
          child: Text(
            'No question found.',
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
              Expanded(child: _buildChurchEnvironmentOptions(question)),

              const SizedBox(height: 24),

              // Continue button
              _buildContinueButton(question),

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
            children: List.generate(5, (index) {
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: index < 4 ? 16 : 0),
                  decoration: BoxDecoration(
                    color: index < 4 ? Colors.white : const Color(0xFF353333),
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

  Widget _buildChurchEnvironmentOptions(Question question) {
    final questionState = ref.watch(questionNotifierProvider);
    final selectedOptionId = questionState.selectedAnswers[question.id];

    return ListView.builder(
      itemCount: question.options.length,
      itemBuilder: (context, index) {
        final option = question.options[index];
        final isSelected = selectedOptionId == option.id;

        // Staggered animation for each option
        final delay = index * 0.1;
        final start = delay;
        final end = start + 0.4;

        final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        );

        final slideAnimation = Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        );

        return SlideTransition(
          position: slideAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _buildChurchEnvironmentCard(
                option: option,
                isSelected: isSelected,
                onTap:
                    () => ref
                        .read(questionNotifierProvider.notifier)
                        .selectAnswer(question.id, option.id),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChurchEnvironmentCard({
    required QuestionOption option,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isSelected
                    ? const Color(0xFF3BC175)
                    : const Color(0xBFBDBD).withOpacity(0.38),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Expanded(
                child: Text(
                  option.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.25,
                  ),
                ),
              ),
            ),
            Spacer(),
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

  Widget _buildContinueButton(Question question) {
    final questionState = ref.watch(questionNotifierProvider);
    final hasSelection = questionState.selectedAnswers.containsKey(question.id);

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed:
            hasSelection
                ? () {
                  // Just navigate to next page (speakers selection)
                  if (widget.onNext != null) {
                    widget.onNext!();
                  } else if (mounted) {
                    context.go('/speaker-selection');
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
