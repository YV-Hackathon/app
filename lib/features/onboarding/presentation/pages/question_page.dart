import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/question_state.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/question_option.dart';
import '../providers/question_provider.dart';

class QuestionPage extends ConsumerStatefulWidget {
  final VoidCallback? onNext;

  const QuestionPage({super.key, this.onNext});

  @override
  ConsumerState<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends ConsumerState<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(questionNotifierProvider);
    final questionNotifier = ref.read(questionNotifierProvider.notifier);

    if (questionState.questions.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF121212),
        body: Center(
          child: Text(
            'No questions found.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final currentQuestion =
        questionState.questions[questionState.currentQuestionIndex];

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
              _buildProgressBar(questionState),

              const SizedBox(height: 70),

              // Description section
              _buildDescriptionSection(currentQuestion),

              const SizedBox(height: 24),

              // Question options
              Expanded(
                child: _buildQuestionOptions(
                  currentQuestion,
                  questionState,
                  questionNotifier,
                ),
              ),

              const SizedBox(height: 24),

              // Continue button
              _buildContinueButton(questionState, questionNotifier),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(QuestionState state) {
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
                    color: index < 2 ? Colors.white : const Color(0xFF353333),
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

  Widget _buildDescriptionSection(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.subtitle,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFFBFBDBD),
            height: 1.25,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          question.title,
          style: const TextStyle(
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

  Widget _buildQuestionOptions(
    Question question,
    QuestionState state,
    QuestionNotifier notifier,
  ) {
    return ListView.builder(
      itemCount: question.options.length,
      itemBuilder: (context, index) {
        final option = question.options[index];
        final isSelected = state.selectedAnswers[question.id] == option.id;

        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _buildOptionCard(
            option: option,
            isSelected: isSelected,
            onTap: () => notifier.selectAnswer(question.id, option.id),
          ),
        );
      },
    );
  }

  Widget _buildOptionCard({
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
                    option.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    option.description,
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

  Widget _buildContinueButton(QuestionState state, QuestionNotifier notifier) {
    final hasSelection = notifier.hasSelectedAnswer;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed:
            hasSelection
                ? () {
                  notifier.nextQuestion();
                  // Use callback if provided, otherwise use default navigation
                  if (widget.onNext != null) {
                    widget.onNext!();
                  } else if (mounted) {
                    context.go('/teaching-style');
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
