import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/global_providers/api_providers.dart';
import '../../domain/entities/church.dart';
import '../../domain/repositories/church_recommendation_repository.dart';
import '../../data/repositories/church_recommendation_repository_impl.dart';

part 'church_recommendation_provider.g.dart';

@riverpod
ChurchRecommendationRepository churchRecommendationRepository(
  ChurchRecommendationRepositoryRef ref,
) {
  final apiClient = ref.watch(apiClientProvider);
  return ChurchRecommendationRepositoryImpl(apiClient);
}

@riverpod
class ChurchRecommendationNotifier extends _$ChurchRecommendationNotifier {
  @override
  Future<List<Church>> build(int userId) async {
    final repository = ref.watch(churchRecommendationRepositoryProvider);
    return await repository.getChurchRecommendations(userId);
  }

  Future<void> refreshRecommendations() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(churchRecommendationRepositoryProvider);
      return await repository.getChurchRecommendations(userId);
    });
  }
}
