import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/question_option.dart';

part 'question_option_model.freezed.dart';
part 'question_option_model.g.dart';

@freezed
class QuestionOptionModel with _$QuestionOptionModel {
  const factory QuestionOptionModel({
    required String id,
    required String title,
    required String description,
    @Default(false) bool isSelected,
  }) = _QuestionOptionModel;

  factory QuestionOptionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionOptionModelFromJson(json);
}

extension QuestionOptionModelX on QuestionOptionModel {
  QuestionOption toEntity() {
    return QuestionOption(
      id: id,
      title: title,
      description: description,
      isSelected: isSelected,
    );
  }
}
