import 'package:freezed_annotation/freezed_annotation.dart';

part 'personalization_instructions.freezed.dart';

@freezed
class PersonalizationInstructions with _$PersonalizationInstructions {
  const factory PersonalizationInstructions({
    required String id,
    required String title,
    required String description,
    required List<String> videoClips, // List of video clip URLs or asset paths
    required bool
    showLikeButton, // Whether to show the like button on one of the cards
  }) = _PersonalizationInstructions;
}



