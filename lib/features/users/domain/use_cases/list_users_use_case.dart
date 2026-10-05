import '../entities/user.dart';
import '../repositories/user_repository.dart';

class ListUsersUseCase {
  final UserRepository _repository;
  ListUsersUseCase(this._repository);

  Future<List<User>> call({String? search}) async {
    final users = await _repository.listUsers();
    if (search == null || search.trim().isEmpty) return users;
    final query = search.toLowerCase().trim();
    return users
        .where((u) => u.username.toLowerCase().contains(query))
        .toList();
  }
}