import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../../../../shared/services/network_service.dart';
import '../../../../shared/services/storage_service.dart';
import '../../../../shared/utils/result.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkService _networkService;
  final StorageService _storageService;

  const AuthRepositoryImpl({
    required NetworkService networkService,
    required StorageService storageService,
  }) : _networkService = networkService,
       _storageService = storageService;

  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'current_user';

  @override
  FutureResult<UserEntity> login(String email, String password) async {
    try {
      // For now, we'll simulate a login API call
      // In a real app, you would call your actual authentication endpoint
      final response = await _networkService.createUser({
        'email': email,
        'password': password,
        'action': 'login',
      });

      // Simulate successful login
      final user = UserEntity(
        id: response['id'] ?? '1',
        email: email,
        name: response['name'] ?? 'User',
        avatarUrl: response['avatarUrl'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Store token and user data
      await _storageService.setString(_tokenKey, 'mock_token_${user.id}');
      await _storageService.setString(_userKey, user.toString());

      return success(user);
    } on ServerException catch (e) {
      return failure(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return failure(NetworkFailure(message: e.message));
    } catch (e) {
      return failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  FutureResult<UserEntity> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // For now, we'll simulate a registration API call
      final response = await _networkService.createUser({
        'email': email,
        'password': password,
        'name': name,
        'action': 'register',
      });

      // Simulate successful registration
      final user = UserEntity(
        id: response['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: name,
        avatarUrl: response['avatarUrl'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Store token and user data
      await _storageService.setString(_tokenKey, 'mock_token_${user.id}');
      await _storageService.setString(_userKey, user.toString());

      return success(user);
    } on ServerException catch (e) {
      return failure(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return failure(NetworkFailure(message: e.message));
    } catch (e) {
      return failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  FutureResult<void> logout() async {
    try {
      // Remove stored authentication data
      await _storageService.remove(_tokenKey);
      await _storageService.remove(_userKey);

      return success(null);
    } catch (e) {
      return failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  FutureResult<UserEntity?> getCurrentUser() async {
    try {
      final token = await _storageService.getString(_tokenKey);
      final userData = await _storageService.getString(_userKey);

      if (token == null || userData == null) {
        return success(null);
      }

      // In a real app, you would validate the token with your backend
      // For now, we'll return a mock user if token exists
      final user = UserEntity(
        id: '1',
        email: 'user@example.com',
        name: 'Current User',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      return success(user);
    } catch (e) {
      return failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  FutureResult<bool> isAuthenticated() async {
    try {
      final token = await _storageService.getString(_tokenKey);
      return success(token != null);
    } catch (e) {
      return failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  FutureResult<UserEntity> refreshToken() async {
    try {
      final token = await _storageService.getString(_tokenKey);

      if (token == null) {
        return failure(AuthFailure(message: 'No token to refresh'));
      }

      // In a real app, you would call your refresh token endpoint
      // For now, we'll return the current user
      final user = UserEntity(
        id: '1',
        email: 'user@example.com',
        name: 'Current User',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      return success(user);
    } on ServerException catch (e) {
      return failure(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return failure(NetworkFailure(message: e.message));
    } catch (e) {
      return failure(UnknownFailure(message: e.toString()));
    }
  }
}
