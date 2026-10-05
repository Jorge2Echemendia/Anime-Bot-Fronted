import '../entities/admin.dart';

abstract interface class AuthRepository {
  Future<Admin> login(String username, String password);
  Future<void> logout();
  Future<Admin?> getCurrentAdmin();
}