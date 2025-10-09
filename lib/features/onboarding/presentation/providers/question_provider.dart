import 'package:gloo_hackathon/features/onboarding/domain/entities/question.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/question_state.dart';
import 'question_dependencies_provider.dart';

part 'question_provider.g.dart';

@riverpod
class QuestionNotifier extends _$QuestionNotifier {
  @override
  QuestionState build() {
    // Schedule loading for after initialization
    Future.microtask(() => _loadQuestions());
    return const QuestionState(isLoading: true);
  }

  Future<void> _loadQuestions() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final useCase = ref.read(getQuestionsUseCaseProvider);
      final result = await useCase();

      result.fold(
        (failure) =>
            state = state.copyWith(isLoading: false, error: failure.message),
        (questions) =>
            state = state.copyWith(
              isLoading: false,
              questions: questions,
              error: null,
            ),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> retry() async {
    await _loadQuestions();
  }

  void selectAnswer(String questionId, String optionId) {
    final currentAnswers = Map<String, String>.from(state.selectedAnswers);
    currentAnswers[questionId] = optionId;
    state = state.copyWith(selectedAnswers: currentAnswers);
  }

  /// Toggle speaker selection for multi-select questions (like speakers)
  void toggleSpeaker(String speakerId) {
    final updatedQuestions =
        state.questions.map((question) {
          if (question.id == 'speakers') {
            final updatedOptions =
                question.options.map((option) {
                  if (option.id == speakerId) {
                    return option.copyWith(isSelected: !option.isSelected);
                  }
                  return option;
                }).toList();
            return question.copyWith(options: updatedOptions);
          }
          return question;
        }).toList();

    state = state.copyWith(questions: updatedQuestions);
  }

  /// Get list of selected speaker IDs
  List<String> getSelectedSpeakers() {
    final speakersQuestion = state.questions.firstWhere(
      (q) => q.id == 'speakers',
      orElse:
          () => const Question(
            id: '',
            title: '',
            description: '',
            type: '',
            options: [],
          ),
    );
    return speakersQuestion.options
        .where((option) => option.isSelected)
        .map((option) => option.id)
        .toList();
  }

  void nextQuestion() {
    if (state.currentQuestionIndex < state.questions.length - 1) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
      );
    }
  }

  void previousQuestion() {
    if (state.currentQuestionIndex > 0) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex - 1,
      );
    }
  }

  bool get hasSelectedAnswer {
    final currentQuestion =
        state.questions.isNotEmpty
            ? state.questions[state.currentQuestionIndex]
            : null;
    if (currentQuestion == null) return false;
    return state.selectedAnswers.containsKey(currentQuestion.id);
  }
}
