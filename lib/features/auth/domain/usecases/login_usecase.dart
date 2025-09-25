import '../../../../shared/utils/result.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  FutureResult<UserEntity> call({
    required String email,
    required String password,
  }) {
    return _repository.login(email, password);
  }
}
