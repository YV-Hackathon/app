import '../../../../shared/utils/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/personalization_instructions.dart';
import '../repositories/personalization_instructions_repository.dart';

abstract class GetPersonalizationInstructionsUseCase {
  FutureResult<List<PersonalizationInstructions>> call();
}

class GetPersonalizationInstructionsUseCaseImpl
    implements GetPersonalizationInstructionsUseCase {
  final PersonalizationInstructionsRepository _repository;

  GetPersonalizationInstructionsUseCaseImpl(this._repository);

  @override
  FutureResult<List<PersonalizationInstructions>> call() async {
    try {
      final personalizationInstructions =
          await _repository.getPersonalizationInstructions();
      return success(personalizationInstructions);
    } catch (e) {
      return failure(ServerFailure(message: e.toString()));
    }
  }
}



