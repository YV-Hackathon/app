import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/entities/user_entity.dart';
import '../../../../shared/services/network_service.dart';
import '../../../../shared/services/storage_service.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<UserEntity?> build() async {
    // Initialize auth state
    final repository = AuthRepositoryImpl(
      networkService: ref.read(networkServiceProvider),
      storageService: ref.read(storageServiceProvider),
    );

    final result = await repository.getCurrentUser();
    return result.fold((failure) => null, (user) => user);
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();

    final repository = AuthRepositoryImpl(
      networkService: ref.read(networkServiceProvider),
      storageService: ref.read(storageServiceProvider),
    );

    final loginUseCase = LoginUseCase(repository);
    final result = await loginUseCase(email: email, password: password);

    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (user) => state = AsyncValue.data(user),
    );
  }

  Future<void> register(String email, String password, String name) async {
    state = const AsyncValue.loading();

    final repository = AuthRepositoryImpl(
      networkService: ref.read(networkServiceProvider),
      storageService: ref.read(storageServiceProvider),
    );

    final registerUseCase = RegisterUseCase(repository);
    final result = await registerUseCase(
      email: email,
      password: password,
      name: name,
    );

    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (user) => state = AsyncValue.data(user),
    );
  }

  Future<void> logout() async {
    final repository = AuthRepositoryImpl(
      networkService: ref.read(networkServiceProvider),
      storageService: ref.read(storageServiceProvider),
    );

    await repository.logout();
    state = const AsyncValue.data(null);
  }
}

@riverpod
NetworkService networkService(NetworkServiceRef ref) {
  return NetworkServiceFactory.create();
}

@riverpod
StorageService storageService(StorageServiceRef ref) {
  return SharedPreferencesStorageService();
}
