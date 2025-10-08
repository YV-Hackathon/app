import '../../../../shared/utils/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/speaker.dart';
import '../repositories/speaker_repository.dart';

abstract class GetSpeakersUseCase {
  FutureResult<List<Speaker>> call();
}

class GetSpeakersUseCaseImpl implements GetSpeakersUseCase {
  final SpeakerRepository _repository;

  GetSpeakersUseCaseImpl(this._repository);

  @override
  FutureResult<List<Speaker>> call() async {
    try {
      final speakers = await _repository.getSpeakers();
      return success(speakers);
    } catch (e) {
      return failure(ServerFailure(message: e.toString()));
    }
  }
}
