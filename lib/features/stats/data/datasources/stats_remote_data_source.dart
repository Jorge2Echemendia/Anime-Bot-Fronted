import '../../../../core/network/api_client.dart';
import '../models/stats_dto.dart';

class StatsRemoteDataSource {
  final ApiClient _client;
  StatsRemoteDataSource(this._client);

  Future<StatsDto> getStats() async {
    final response = await _client.get('/stats');
    return StatsDto.fromJson(response['data'] as Map<String, dynamic>);
  }
}