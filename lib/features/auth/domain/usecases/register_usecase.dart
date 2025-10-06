import '../../../../shared/utils/result.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  FutureResult<UserEntity> call({
    required String email,
    required String password,
    required String name,
  }) {
    return _repository.register(email: email, password: password, name: name);
  }
}
