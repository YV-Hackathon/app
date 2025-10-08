import '../../../../shared/utils/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/playlist_instructions.dart';
import '../repositories/playlist_instructions_repository.dart';

abstract class GetPlaylistInstructionsUseCase {
  FutureResult<List<PlaylistInstructions>> call();
}

class GetPlaylistInstructionsUseCaseImpl
    implements GetPlaylistInstructionsUseCase {
  final PlaylistInstructionsRepository _repository;

  GetPlaylistInstructionsUseCaseImpl(this._repository);

  @override
  FutureResult<List<PlaylistInstructions>> call() async {
    try {
      final playlistInstructions = await _repository.getPlaylistInstructions();
      return success(playlistInstructions);
    } catch (e) {
      return failure(ServerFailure(message: e.toString()));
    }
  }
}



