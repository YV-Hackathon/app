import '../../domain/entities/playlist_instructions.dart';
import '../../domain/repositories/playlist_instructions_repository.dart';
import '../datasources/playlist_instructions_local_datasource.dart';

class PlaylistInstructionsRepositoryImpl
    implements PlaylistInstructionsRepository {
  final PlaylistInstructionsLocalDataSource _localDataSource;

  PlaylistInstructionsRepositoryImpl(this._localDataSource);

  @override
  Future<List<PlaylistInstructions>> getPlaylistInstructions() async {
    final playlistInstructionsModels =
        await _localDataSource.getPlaylistInstructions();
    return playlistInstructionsModels
        .map(
          (model) => PlaylistInstructions(
            id: model.id,
            title: model.title,
            description: model.description,
            videoClips: model.videoClips,
            showSkipButton: model.showSkipButton,
            buttonText: model.buttonText,
          ),
        )
        .toList();
  }
}



