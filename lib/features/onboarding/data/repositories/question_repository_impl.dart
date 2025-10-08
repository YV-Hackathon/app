import '../../domain/entities/question.dart';
import '../../domain/entities/question_option.dart';
import '../../domain/repositories/question_repository.dart';
import '../datasources/question_local_datasource.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionLocalDataSource _localDataSource;

  QuestionRepositoryImpl(this._localDataSource);

  @override
  Future<List<Question>> getQuestions() async {
    final questionModels = await _localDataSource.getQuestions();
    return questionModels
        .map(
          (model) => Question(
            id: model.id,
            title: model.title,
            subtitle: model.subtitle,
            options:
                model.options
                    .map(
                      (option) => QuestionOption(
                        id: option.id,
                        title: option.title,
                        description: option.description,
                        isSelected: option.isSelected,
                      ),
                    )
                    .toList(),
          ),
        )
        .toList();
  }
}
