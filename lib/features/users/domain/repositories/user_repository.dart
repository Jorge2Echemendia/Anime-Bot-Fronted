import '../entities/user.dart';

abstract interface class UserRepository {
  Future<List<User>> listUsers();
  Future<User> getUser(String id);
  Future<void> warnUser(String id, String reason);
  Future<void> unbanUser(String id);
}