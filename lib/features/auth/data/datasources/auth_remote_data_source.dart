import '../../../../core/network/api_client.dart';
import '../models/login_response_dto.dart';

class AuthRemoteDataSource {
  final ApiClient _client;
  AuthRemoteDataSource(this._client);

  Future<LoginResponseDto> login(String username, String password) async {
    final response = await _client.post(
      '/auth/login',
      body: {'username': username, 'password': password},
    );
    return LoginResponseDto.fromJson(response['data'] as Map<String, dynamic>);
  }
}