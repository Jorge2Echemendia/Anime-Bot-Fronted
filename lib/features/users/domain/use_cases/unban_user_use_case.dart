import '../repositories/user_repository.dart';

class UnbanUserUseCase {
  final UserRepository _repository;
  UnbanUserUseCase(this._repository);

  Future<void> call(String userId) {
    if (userId.trim().isEmpty) {
      throw ArgumentError('El ID del usuario no puede estar vacío');
    }
    return _repository.unbanUser(userId);
  }
}