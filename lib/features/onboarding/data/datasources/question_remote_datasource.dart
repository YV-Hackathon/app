import '../../../../core/api/api_client.dart';
import '../../../../core/error/exceptions.dart';
import '../models/question_model.dart';

abstract class QuestionRemoteDataSource {
  Future<List<QuestionModel>> getQuestions();
}

class QuestionRemoteDataSourceImpl implements QuestionRemoteDataSource {
  final ApiClient _apiClient;

  QuestionRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<QuestionModel>> getQuestions() async {
    try {
      print('🌐 Fetching questions from API...');
      print('🔍 API Client: $_apiClient');
      final response = await _apiClient.getOnboardingQuestions();
      print('✅ API Response received: ${response.length} questions');

      // Debug print each question
      for (var i = 0; i < response.length; i++) {
        final question = response[i];
        print('📝 Question $i:');
        print('  - ID: ${question.id}');
        print('  - Title: ${question.title}');
        print('  - Type: ${question.type}');
        print('  - Options count: ${question.options.length}');
        if (question.options.isNotEmpty) {
          print('  - First option: ${question.options.first.label}');
          print('  - First option value: ${question.options.first.value}');
          print(
            '  - First option profilePictureUrl: ${question.options.first.profilePictureUrl}',
          );
        }
      }

      return response;
    } catch (e, stackTrace) {
      print('❌ Error in data source: $e');
      print('❌ Error type: ${e.runtimeType}');
      print('📍 Stack trace: $stackTrace');
      throw ServerException(
        message: 'Failed to fetch onboarding questions: $e',
      );
    }
  }
}
