import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/playlist_instructions_state.dart';
import '../../domain/entities/playlist_instructions.dart';

part 'playlist_instructions_provider.g.dart';

@riverpod
class PlaylistInstructionsNotifier extends _$PlaylistInstructionsNotifier {
  @override
  PlaylistInstructionsState build() {
    // Create mock playlist instructions directly and return them immediately
    final playlistInstructions = <PlaylistInstructions>[
      const PlaylistInstructions(
        id: '1',
        title: 'Swipe left to explore different styles',
        description: 'Discover different preaching styles',
        videoClips: [
          'assets/videos/pastor_clip_1.mp4',
          'assets/videos/pastor_clip_2.mp4',
          'assets/videos/pastor_clip_3.mp4',
        ],
        showSkipButton: true,
        buttonText: 'Begin Playlist',
      ),
    ];

    return PlaylistInstructionsState(
      playlistInstructions: playlistInstructions,
    );
  }
}



