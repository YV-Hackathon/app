import '../../../../shared/utils/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/loading_screen.dart';
import '../repositories/loading_screen_repository.dart';

abstract class GetLoadingScreensUseCase {
  FutureResult<List<LoadingScreen>> call();
}

class GetLoadingScreensUseCaseImpl implements GetLoadingScreensUseCase {
  final LoadingScreenRepository _repository;

  GetLoadingScreensUseCaseImpl(this._repository);

  @override
  FutureResult<List<LoadingScreen>> call() async {
    try {
      final loadingScreens = await _repository.getLoadingScreens();
      return success(loadingScreens);
    } catch (e) {
      return failure(ServerFailure(message: e.toString()));
    }
  }
}



