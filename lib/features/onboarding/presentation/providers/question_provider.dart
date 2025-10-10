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
        (questions) {
          print(
            '📚 ==================== QUESTIONS LOADED ====================',
          );
          print('   Total questions: ${questions.length}');
          for (var i = 0; i < questions.length; i++) {
            final q = questions[i];
            print('   [$i] ID: "${q.id}"');
            print('       Title: ${q.title}');
            print('       Type: ${q.type}');
            print('       Options: ${q.options.length}');
            if (q.id == 'speakers') {
              print('       ⭐ This is the SPEAKERS question!');
            }
          }
          print('📚 ========================================================');

          return state = state.copyWith(
            isLoading: false,
            questions: questions,
            error: null,
          );
        },
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
    print('🎯 toggleSpeaker called for speaker ID: $speakerId');

    final updatedQuestions =
        state.questions.map((question) {
          if (question.id == 'speakers') {
            print('   Found speakers question');
            final updatedOptions =
                question.options.map((option) {
                  if (option.id == speakerId) {
                    print(
                      '   Toggling speaker: ${option.title} from ${option.isSelected} to ${!option.isSelected}',
                    );
                    return option.copyWith(isSelected: !option.isSelected);
                  }
                  return option;
                }).toList();
            return question.copyWith(options: updatedOptions);
          }
          return question;
        }).toList();

    state = state.copyWith(questions: updatedQuestions);

    // Log current selection
    final selectedCount =
        updatedQuestions
            .firstWhere((q) => q.id == 'speakers')
            .options
            .where((o) => o.isSelected)
            .length;
    print('   Total speakers now selected: $selectedCount');
  }

  /// Get list of selected speaker IDs
  List<String> getSelectedSpeakers() {
    print('🔍 getSelectedSpeakers called');
    print('   Total questions loaded: ${state.questions.length}');
    print('   Question IDs: ${state.questions.map((q) => q.id).toList()}');

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

    print('   Speakers question found: ${speakersQuestion.id.isNotEmpty}');
    print(
      '   Speakers question options count: ${speakersQuestion.options.length}',
    );

    final selectedSpeakers =
        speakersQuestion.options
            .where((option) => option.isSelected)
            .map((option) => option.id)
            .toList();

    print(
      '   Selected speakers: $selectedSpeakers (${selectedSpeakers.length} selected)',
    );

    return selectedSpeakers;
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
