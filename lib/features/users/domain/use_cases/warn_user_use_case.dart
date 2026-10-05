import '../repositories/user_repository.dart';

class WarnUserUseCase {
  final UserRepository _repository;
  WarnUserUseCase(this._repository);

  Future<void> call(String userId, String reason) {
    if (reason.trim().isEmpty) {
      throw ArgumentError('El motivo es obligatorio');
    }
    return _repository.warnUser(userId, reason);
  }
}