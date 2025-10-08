import '../models/playlist_instructions_model.dart';

abstract class PlaylistInstructionsLocalDataSource {
  Future<List<PlaylistInstructionsModel>> getPlaylistInstructions();
}

class PlaylistInstructionsLocalDataSourceImpl
    implements PlaylistInstructionsLocalDataSource {
  @override
  Future<List<PlaylistInstructionsModel>> getPlaylistInstructions() async {
    return [
      const PlaylistInstructionsModel(
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
  }
}



