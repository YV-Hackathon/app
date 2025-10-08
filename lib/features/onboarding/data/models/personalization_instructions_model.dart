import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/personalization_instructions.dart';

part 'personalization_instructions_model.freezed.dart';
part 'personalization_instructions_model.g.dart';

@freezed
class PersonalizationInstructionsModel with _$PersonalizationInstructionsModel {
  const factory PersonalizationInstructionsModel({
    required String id,
    required String title,
    required String description,
    required List<String> videoClips,
    required bool showLikeButton,
  }) = _PersonalizationInstructionsModel;

  factory PersonalizationInstructionsModel.fromJson(
    Map<String, dynamic> json,
  ) => _$PersonalizationInstructionsModelFromJson(json);
}

extension PersonalizationInstructionsModelX
    on PersonalizationInstructionsModel {
  PersonalizationInstructions toEntity() {
    return PersonalizationInstructions(
      id: id,
      title: title,
      description: description,
      videoClips: videoClips,
      showLikeButton: showLikeButton,
    );
  }
}



