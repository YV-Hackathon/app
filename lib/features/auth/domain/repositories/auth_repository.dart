import '../../../../shared/utils/result.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Authenticates a user with email and password
  FutureResult<UserEntity> login(String email, String password);

  /// Registers a new user with email, password, and name
  FutureResult<UserEntity> register({
    required String email,
    required String password,
    required String name,
  });

  /// Logs out the current user
  FutureResult<void> logout();

  /// Gets the current authenticated user
  FutureResult<UserEntity?> getCurrentUser();

  /// Checks if the user is currently authenticated
  FutureResult<bool> isAuthenticated();

  /// Refreshes the authentication token
  FutureResult<UserEntity> refreshToken();
}
