import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository _repository;
  GetUserUseCase(this._repository);

  Future<User> call(String userId) {
    if (userId.trim().isEmpty) {
      throw ArgumentError('El ID del usuario no puede estar vacío');
    }
    return _repository.getUser(userId);
  }
}