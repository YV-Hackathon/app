import 'package:freezed_annotation/freezed_annotation.dart';
import 'playlist_instructions.dart';

part 'playlist_instructions_state.freezed.dart';

@freezed
class PlaylistInstructionsState with _$PlaylistInstructionsState {
  const factory PlaylistInstructionsState({
    @Default([]) List<PlaylistInstructions> playlistInstructions,
    @Default(false) bool isLoading,
    String? error,
  }) = _PlaylistInstructionsState;
}



