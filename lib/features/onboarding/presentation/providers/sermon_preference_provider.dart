import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/global_providers/api_providers.dart';
import '../../data/models/sermon_preference_request.dart';
import '../../data/repositories/sermon_preference_repository_impl.dart';
import '../../domain/repositories/sermon_preference_repository.dart';
import '../../domain/usecases/submit_sermon_preference_usecase.dart';

part 'sermon_preference_provider.g.dart';

/// Repository Provider
@Riverpod(keepAlive: true)
SermonPreferenceRepository sermonPreferenceRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return SermonPreferenceRepositoryImpl(apiClient);
}

/// Use Case Provider
@Riverpod(keepAlive: true)
SubmitSermonPreferenceUseCase submitSermonPreferenceUseCase(Ref ref) {
  final repository = ref.watch(sermonPreferenceRepositoryProvider);
  return SubmitSermonPreferenceUseCaseImpl(repository);
}

/// Notifier for submitting sermon preferences
@riverpod
class SermonPreferenceNotifier extends _$SermonPreferenceNotifier {
  @override
  void build() {
    // No initial state needed
  }

  /// Submit preference in background (fire and forget)
  Future<void> submitPreference({
    required int userId,
    required int sermonId,
    required SermonPreference preference,
  }) async {
    try {
      final request = SermonPreferenceRequest(
        userId: userId,
        sermonId: sermonId,
        preference: preference.value,
      );

      final useCase = ref.read(submitSermonPreferenceUseCaseProvider);
      await useCase(request);
    } catch (e) {
      // Silent fail - don't block user interaction
      print('⚠️ Failed to submit preference (non-blocking): $e');
    }
  }
}
