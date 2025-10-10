import '../entities/church.dart';
import '../../data/models/church_recommendation_response.dart';

abstract class ChurchRecommendationRepository {
  Future<List<Church>> getChurchRecommendations(int userId);
}

