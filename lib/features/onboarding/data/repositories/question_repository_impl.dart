import 'package:gloo_hackathon/features/onboarding/data/models/question_model.dart';

import '../../domain/entities/question.dart';
import '../../domain/repositories/question_repository.dart';
import '../datasources/question_remote_datasource.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionRemoteDataSource _remoteDataSource;

  QuestionRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Question>> getQuestions() async {
    print('🏦 Repository: Starting to fetch questions...');
    try {
      final questionModels = await _remoteDataSource.getQuestions();
      print('🏦 Repository: Received ${questionModels.length} question models');

      final questionsList =
          questionModels.map((model) => model.toEntity()).toList();

      print('🏦 Repository: Converted to ${questionsList.length} entities');
      print('🏦 Repository: Returning questions list');

      return questionsList;
    } catch (e, stackTrace) {
      print('❌ Error in repository: $e');
      print('📍 Stack trace: $stackTrace');
      rethrow;
    }
  }
}
