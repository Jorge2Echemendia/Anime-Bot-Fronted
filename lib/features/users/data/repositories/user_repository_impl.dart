import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_dto.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remote;
  UserRepositoryImpl(this._remote);

  @override
  Future<List<User>> listUsers() async {
    final dtos = await _remote.listUsers();
    return dtos.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<User> getUser(String id) async {
    final dto = await _remote.getUser(id);
    return dto.toDomain();
  }

  @override
  Future<void> warnUser(String id, String reason) =>
      _remote.warnUser(id, reason);

  @override
  Future<void> unbanUser(String id) => _remote.unbanUser(id);
}