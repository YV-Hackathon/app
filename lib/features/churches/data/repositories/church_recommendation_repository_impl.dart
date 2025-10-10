import '../../../../core/api/api_client.dart';
import '../../domain/repositories/church_recommendation_repository.dart';
import '../../domain/entities/church.dart';

class ChurchRecommendationRepositoryImpl
    implements ChurchRecommendationRepository {
  final ApiClient _apiClient;

  ChurchRecommendationRepositoryImpl(this._apiClient);

  @override
  Future<List<Church>> getChurchRecommendations(int userId) async {
    try {
      print('📤 Fetching church recommendations for user: $userId');
      print('📋 Query params: limit=10, use_ai=true, refresh=false');

      final response = await _apiClient.getChurchRecommendations(
        userId,
        limit: 10,
        useAi: true,
        refresh: false,
      );

      print('✅ Church recommendations fetched successfully!');
      print('📊 Total recommendations: ${response.recommendations.length}');
      print('📦 Response: ${response.toJson()}');

      // Convert API response to domain entities
      final churches =
          response.recommendations.map((recommendation) {
            // Create attributes from denomination and recommendation reasons
            final attributes = <String>[
              recommendation.denomination,
              if (recommendation.membershipCount != null)
                '${recommendation.membershipCount} members',
              ...recommendation.recommendationReasons,
            ];

            // Use image from API or default image
            final imageUrl =
                recommendation.imageUrl ??
                'assets/images/church_avatars/church_avatar_1.png';

            return Church(
              id: recommendation.churchId.toString(),
              name: recommendation.churchName,
              description:
                  recommendation.description ?? 'No description available',
              imageUrl: imageUrl,
              distance:
                  -1, // API doesn't provide distance, default to -1 (online)
              rating:
                  recommendation.compatibilityScore *
                  100, // Convert score to percentage
              attributes: attributes,
              isOnline: true, // Default to online since no distance info
              compatibilityScore: recommendation.compatibilityScore,
              recommendationReasons: recommendation.recommendationReasons,
            );
          }).toList();

      return churches;
    } catch (e, stackTrace) {
      print('❌ Error fetching church recommendations: $e');
      print('📍 Stack trace: $stackTrace');
      rethrow;
    }
  }
}
