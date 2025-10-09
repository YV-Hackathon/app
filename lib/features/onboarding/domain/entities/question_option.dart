import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_option.freezed.dart';

@freezed
class QuestionOption with _$QuestionOption {
  const factory QuestionOption({
    required String id,
    required String title,
    required String description,
    String? imageUrl,
    @Default(false) bool isSelected,
  }) = _QuestionOption;
}
