import 'package:anime_bot_fronted/features/auth/data/datasources/auth_remote_data_source.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../domain/entities/admin.dart';
import '../../domain/repositories/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final SecureStorage _storage;

  AuthRepositoryImpl(this._remote, this._storage);

  @override
  Future<Admin> login(String username, String password) async {
    final dto = await _remote.login(username, password);
    await _storage.saveToken(dto.token);
    await _storage.saveUsername(dto.username);
    return Admin(username: dto.username, token: dto.token);
  }

  @override
  Future<void> logout() => _storage.deleteToken();

  @override
  Future<Admin?> getCurrentAdmin() async {
    final token = await _storage.readToken();
    final username = await _storage.readUsername();
    if (token == null || username == null) return null;
    return Admin(username: username, token: token);
  }
}