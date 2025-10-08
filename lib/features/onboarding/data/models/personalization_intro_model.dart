import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/personalization_intro.dart';

part 'personalization_intro_model.freezed.dart';
part 'personalization_intro_model.g.dart';

@freezed
class PersonalizationIntroModel with _$PersonalizationIntroModel {
  const factory PersonalizationIntroModel({
    required String id,
    required String title,
    required String description,
    required List<String> videoClips,
  }) = _PersonalizationIntroModel;

  factory PersonalizationIntroModel.fromJson(Map<String, dynamic> json) =>
      _$PersonalizationIntroModelFromJson(json);
}

extension PersonalizationIntroModelX on PersonalizationIntroModel {
  PersonalizationIntro toEntity() {
    return PersonalizationIntro(
      id: id,
      title: title,
      description: description,
      videoClips: videoClips,
    );
  }
}



