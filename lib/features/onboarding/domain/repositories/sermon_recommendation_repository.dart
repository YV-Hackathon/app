import '../../data/models/sermon_recommendation_response.dart';

abstract class SermonRecommendationRepository {
  Future<SermonRecommendationResponse> getRecommendations(int userId);
}
