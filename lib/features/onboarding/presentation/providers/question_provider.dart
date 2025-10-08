import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/question_state.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/question_option.dart';

part 'question_provider.g.dart';

@riverpod
class QuestionNotifier extends _$QuestionNotifier {
  @override
  QuestionState build() {
    // Create mock questions directly and return them immediately
    final questions = <Question>[
      Question(
        id: '1',
        title: 'When you read the Bible, what\'s most helpful for you?',
        subtitle: 'Find a Church',
        options: [
          const QuestionOption(
            id: '1',
            title: 'More Scripture',
            description: 'Focused on reading large sections of the text',
          ),
          const QuestionOption(
            id: '2',
            title: 'Life Application',
            description: 'Practical guidance for everyday life',
          ),
          const QuestionOption(
            id: '3',
            title: 'Balanced',
            description: 'A mix of both Scripture and life application.',
          ),
        ],
      ),
    ];

    return QuestionState(questions: questions);
  }

  void selectAnswer(String questionId, String optionId) {
    final currentAnswers = Map<String, String>.from(state.selectedAnswers);
    currentAnswers[questionId] = optionId;
    state = state.copyWith(selectedAnswers: currentAnswers);
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
