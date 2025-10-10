import '../entities/church.dart';

abstract class ChurchRecommendationRepository {
  Future<List<Church>> getChurchRecommendations(int userId);
}
