import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/question.dart';
import 'question_option_model.dart';

part 'question_model.freezed.dart';
part 'question_model.g.dart';

@freezed
class QuestionModel with _$QuestionModel {
  const factory QuestionModel({
    required String id,
    required String title,
    required String subtitle,
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
      subtitle: subtitle,
      options: options.map((option) => option.toEntity()).toList(),
    );
  }
}
