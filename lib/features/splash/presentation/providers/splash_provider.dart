import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/splash_state.dart';
import '../../domain/usecases/initialize_app_usecase.dart';
import '../../../../shared/services/network_service.dart';
import '../../../../shared/services/storage_service.dart';

part 'splash_provider.g.dart';

@riverpod
class SplashNotifier extends _$SplashNotifier {
  @override
  SplashState build() {
    _initializeApp();
    return const SplashState();
  }

  Future<void> _initializeApp() async {
    state = state.copyWith(isLoading: true);

    try {
      final useCase = InitializeAppUseCase(
        storageService: ref.read(storageServiceProvider),
        networkService: ref.read(networkServiceProvider),
      );

      final result = await useCase();

      result.fold(
        (failure) =>
            state = state.copyWith(isLoading: false, error: failure.toString()),
        (success) =>
            state = state.copyWith(isLoading: false, isInitialized: success),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void retry() {
    _initializeApp();
  }
}

@riverpod
NetworkService networkService(Ref ref) {
  return NetworkServiceFactory.create();
}

@riverpod
StorageService storageService(Ref ref) {
  return SharedPreferencesStorageService();
}
