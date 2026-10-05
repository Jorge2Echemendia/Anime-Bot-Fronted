import '../entities/admin.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;
  LoginUseCase(this._repository);

  Future<Admin> call(String username, String password) {
    return _repository.login(username, password);
  }
}