import 'package:freezed_annotation/freezed_annotation.dart';
import 'question.dart';

part 'question_state.freezed.dart';

@freezed
class QuestionState with _$QuestionState {
  const factory QuestionState({
    @Default([]) List<Question> questions,
    @Default(false) bool isLoading,
    String? error,
    @Default(0) int currentQuestionIndex,
    @Default({}) Map<String, String> selectedAnswers, // questionId -> optionId
  }) = _QuestionState;
}



