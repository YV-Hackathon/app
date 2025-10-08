import '../../../../shared/utils/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/personalization_intro.dart';
import '../repositories/personalization_intro_repository.dart';

abstract class GetPersonalizationIntrosUseCase {
  FutureResult<List<PersonalizationIntro>> call();
}

class GetPersonalizationIntrosUseCaseImpl
    implements GetPersonalizationIntrosUseCase {
  final PersonalizationIntroRepository _repository;

  GetPersonalizationIntrosUseCaseImpl(this._repository);

  @override
  FutureResult<List<PersonalizationIntro>> call() async {
    try {
      final personalizationIntros =
          await _repository.getPersonalizationIntros();
      return success(personalizationIntros);
    } catch (e) {
      return failure(ServerFailure(message: e.toString()));
    }
  }
}



