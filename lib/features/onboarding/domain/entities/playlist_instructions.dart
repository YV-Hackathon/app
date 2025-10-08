import 'package:freezed_annotation/freezed_annotation.dart';

part 'playlist_instructions.freezed.dart';

@freezed
class PlaylistInstructions with _$PlaylistInstructions {
  const factory PlaylistInstructions({
    required String id,
    required String title,
    required String description,
    required List<String> videoClips, // List of video clip URLs or asset paths
    required bool
    showSkipButton, // Whether to show the skip button on one of the cards
    required String buttonText, // Button text (e.g., "Begin Playlist")
  }) = _PlaylistInstructions;
}



