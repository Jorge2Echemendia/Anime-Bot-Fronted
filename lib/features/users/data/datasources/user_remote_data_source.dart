import '../../../../core/network/api_client.dart';
import '../models/user_dto.dart';

class UserRemoteDataSource {
  final ApiClient _client;
  UserRemoteDataSource(this._client);

  Future<List<UserDto>> listUsers() async {
    final response = await _client.get('/users');
    final list = response['data'] as List<dynamic>;
    return list
        .map((e) => UserDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<UserDto> getUser(String id) async {
    final response = await _client.get('/users/$id');
    return UserDto.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<void> warnUser(String id, String reason) async {
    await _client.post('/users/$id/warn', body: {'reason': reason});
  }

  Future<void> unbanUser(String id) async {
    await _client.post('/users/$id/unban');
  }
}