import '../../data/models/sermon_recommendation_response.dart';
import '../repositories/sermon_recommendation_repository.dart';

abstract class GetSermonRecommendationsUseCase {
  Future<SermonRecommendationResponse> call(int userId);
}

class GetSermonRecommendationsUseCaseImpl
    implements GetSermonRecommendationsUseCase {
  final SermonRecommendationRepository _repository;

  GetSermonRecommendationsUseCaseImpl(this._repository);

  @override
  Future<SermonRecommendationResponse> call(int userId) async {
    return await _repository.getRecommendations(userId);
  }
}
