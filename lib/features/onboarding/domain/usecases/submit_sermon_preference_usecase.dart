import '../../data/models/sermon_preference_request.dart';
import '../../data/models/sermon_preference_response.dart';
import '../repositories/sermon_preference_repository.dart';

abstract class SubmitSermonPreferenceUseCase {
  Future<SermonPreferenceResponse> call(SermonPreferenceRequest request);
}

class SubmitSermonPreferenceUseCaseImpl
    implements SubmitSermonPreferenceUseCase {
  final SermonPreferenceRepository _repository;

  SubmitSermonPreferenceUseCaseImpl(this._repository);

  @override
  Future<SermonPreferenceResponse> call(SermonPreferenceRequest request) async {
    return await _repository.submitPreference(request);
  }
}
