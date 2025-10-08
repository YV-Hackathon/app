import '../../../../shared/utils/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/teaching_style.dart';
import '../repositories/teaching_style_repository.dart';

abstract class GetTeachingStylesUseCase {
  FutureResult<List<TeachingStyle>> call();
}

class GetTeachingStylesUseCaseImpl implements GetTeachingStylesUseCase {
  final TeachingStyleRepository _repository;

  GetTeachingStylesUseCaseImpl(this._repository);

  @override
  FutureResult<List<TeachingStyle>> call() async {
    try {
      final teachingStyles = await _repository.getTeachingStyles();
      return success(teachingStyles);
    } catch (e) {
      return failure(ServerFailure(message: e.toString()));
    }
  }
}



