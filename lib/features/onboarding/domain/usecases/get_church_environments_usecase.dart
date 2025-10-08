import '../../../../shared/utils/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/church_environment.dart';
import '../repositories/church_environment_repository.dart';

abstract class GetChurchEnvironmentsUseCase {
  FutureResult<List<ChurchEnvironment>> call();
}

class GetChurchEnvironmentsUseCaseImpl implements GetChurchEnvironmentsUseCase {
  final ChurchEnvironmentRepository _repository;

  GetChurchEnvironmentsUseCaseImpl(this._repository);

  @override
  FutureResult<List<ChurchEnvironment>> call() async {
    try {
      final churchEnvironments = await _repository.getChurchEnvironments();
      return success(churchEnvironments);
    } catch (e) {
      return failure(ServerFailure(message: e.toString()));
    }
  }
}



