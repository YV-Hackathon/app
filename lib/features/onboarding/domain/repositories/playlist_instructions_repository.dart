import '../entities/playlist_instructions.dart';

abstract class PlaylistInstructionsRepository {
  Future<List<PlaylistInstructions>> getPlaylistInstructions();
}



