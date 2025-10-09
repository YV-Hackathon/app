import '../../../../shared/utils/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/question.dart';
import '../repositories/question_repository.dart';

abstract class GetQuestionsUseCase {
  FutureResult<List<Question>> call();
}

class GetQuestionsUseCaseImpl implements GetQuestionsUseCase {
  final QuestionRepository _repository;

  GetQuestionsUseCaseImpl(this._repository);

  @override
  FutureResult<List<Question>> call() async {
    try {
      final questions = await _repository.getQuestions();
      print('???questions in usecase : ${questions}');
      return success(questions);
    } catch (e) {
      return failure(ServerFailure(message: e.toString()));
    }
  }
}
