import 'package:freezed_annotation/freezed_annotation.dart';
import 'question_option.dart';

part 'question.freezed.dart';

@freezed
class Question with _$Question {
  const factory Question({
    required String id,
    required String title,
    required String description,
    required String type,
    required List<QuestionOption> options,
  }) = _Question;
}
