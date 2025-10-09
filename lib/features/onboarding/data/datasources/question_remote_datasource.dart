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
      print(
        '📝 First question: ${response.isNotEmpty ? response.first : "No questions"}',
      );
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
