import '../../../../core/api/api_client.dart';
import '../../domain/repositories/sermon_recommendation_repository.dart';
import '../models/sermon_recommendation_response.dart';

class SermonRecommendationRepositoryImpl
    implements SermonRecommendationRepository {
  final ApiClient _apiClient;

  SermonRecommendationRepositoryImpl(this._apiClient);

  @override
  Future<SermonRecommendationResponse> getRecommendations(int userId) async {
    try {
      print('📤 Fetching sermon recommendations for user: $userId');
      print('📋 Query params: limit=5, use_ai=true, refresh=true');

      final response = await _apiClient.getRecommendations(
        userId,
        limit: 5,
        useAi: true,
        refresh: false,
      );

      print('✅ Recommendations fetched successfully!');
      print('📊 Total recommendations: ${response.recommendations.length}');
      print('📦 Response: ${response.toJson()}');

      return response;
    } catch (e, stackTrace) {
      print('❌ Error fetching recommendations: $e');
      print('📍 Stack trace: $stackTrace');
      rethrow;
    }
  }
}
