import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/playlist_instructions.dart';

part 'playlist_instructions_model.freezed.dart';
part 'playlist_instructions_model.g.dart';

@freezed
class PlaylistInstructionsModel with _$PlaylistInstructionsModel {
  const factory PlaylistInstructionsModel({
    required String id,
    required String title,
    required String description,
    required List<String> videoClips,
    required bool showSkipButton,
    required String buttonText,
  }) = _PlaylistInstructionsModel;

  factory PlaylistInstructionsModel.fromJson(Map<String, dynamic> json) =>
      _$PlaylistInstructionsModelFromJson(json);
}

extension PlaylistInstructionsModelX on PlaylistInstructionsModel {
  PlaylistInstructions toEntity() {
    return PlaylistInstructions(
      id: id,
      title: title,
      description: description,
      videoClips: videoClips,
      showSkipButton: showSkipButton,
      buttonText: buttonText,
    );
  }
}



