import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/global_providers/api_providers.dart';
import '../../data/models/sermon_recommendation_response.dart';
import '../../data/repositories/sermon_recommendation_repository_impl.dart';
import '../../domain/repositories/sermon_recommendation_repository.dart';
import '../../domain/usecases/get_sermon_recommendations_usecase.dart';

part 'sermon_recommendation_provider.g.dart';

/// Repository Provider
@Riverpod(keepAlive: true)
SermonRecommendationRepository sermonRecommendationRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return SermonRecommendationRepositoryImpl(apiClient);
}

/// Use Case Provider
@Riverpod(keepAlive: true)
GetSermonRecommendationsUseCase getSermonRecommendationsUseCase(Ref ref) {
  final repository = ref.watch(sermonRecommendationRepositoryProvider);
  return GetSermonRecommendationsUseCaseImpl(repository);
}

/// Recommendations State Provider
@riverpod
class SermonRecommendationNotifier extends _$SermonRecommendationNotifier {
  @override
  Future<SermonRecommendationResponse> build(int userId) async {
    return _fetchRecommendations(userId);
  }

  Future<SermonRecommendationResponse> _fetchRecommendations(int userId) async {
    final useCase = ref.read(getSermonRecommendationsUseCaseProvider);
    return await useCase(userId);
  }

  Future<void> refresh(int userId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchRecommendations(userId));
  }
}
