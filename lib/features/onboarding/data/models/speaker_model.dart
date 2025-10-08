import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/speaker.dart';

part 'speaker_model.freezed.dart';
part 'speaker_model.g.dart';

@freezed
class SpeakerModel with _$SpeakerModel {
  const factory SpeakerModel({
    required String id,
    required String name,
    required String imageUrl,
    @Default(false) bool isSelected,
  }) = _SpeakerModel;

  factory SpeakerModel.fromJson(Map<String, dynamic> json) =>
      _$SpeakerModelFromJson(json);
}

extension SpeakerModelX on SpeakerModel {
  Speaker toEntity() {
    return Speaker(
      id: id,
      name: name,
      imageUrl: imageUrl,
      isSelected: isSelected,
    );
  }
}



