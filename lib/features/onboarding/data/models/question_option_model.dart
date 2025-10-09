import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/question_option.dart';

part 'question_option_model.freezed.dart';
part 'question_option_model.g.dart';

@freezed
class QuestionOptionModel with _$QuestionOptionModel {
  const QuestionOptionModel._();

  const factory QuestionOptionModel({
    required String value,
    required String label,
    String? subtitle,
    String? church,
    @JsonKey(name: 'profile_picture_url') String? profilePictureUrl,
    @Default(false) bool isSelected,
  }) = _QuestionOptionModel;

  factory QuestionOptionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionOptionModelFromJson(json);
}

extension QuestionOptionModelX on QuestionOptionModel {
  QuestionOption toEntity() {
    // Build description from subtitle and church
    final descriptionParts = <String>[];
    if (subtitle != null && subtitle!.isNotEmpty) {
      descriptionParts.add(subtitle!);
    }
    if (church != null && church!.isNotEmpty) {
      descriptionParts.add(church!);
    }
    final description = descriptionParts.join(' • ');

    return QuestionOption(
      id: value,
      title: label,
      description: description,
      imageUrl: profilePictureUrl,
      isSelected: isSelected,
    );
  }
}
