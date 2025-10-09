import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/question.dart';
import 'question_option_model.dart';

part 'question_model.freezed.dart';
part 'question_model.g.dart';

@freezed
class QuestionModel with _$QuestionModel {
  const QuestionModel._();

  const factory QuestionModel({
    required String id,
    required String title,
    required String description,
    required String type,
    required List<QuestionOptionModel> options,
  }) = _QuestionModel;

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
}

extension QuestionModelX on QuestionModel {
  Question toEntity() {
    return Question(
      id: id,
      title: title,
      description: description,
      type: type,
      options: options.map((option) => option.toEntity()).toList(),
    );
  }
}
