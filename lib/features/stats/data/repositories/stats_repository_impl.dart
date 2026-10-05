import '../../domain/entities/stats.dart';
import '../../domain/repositories/stats_repository.dart';
import '../datasources/stats_remote_data_source.dart';
import '../models/stats_dto.dart';

class StatsRepositoryImpl implements StatsRepository {
  final StatsRemoteDataSource _remote;
  StatsRepositoryImpl(this._remote);

  @override
  Future<Stats> getStats() async {
    final dto = await _remote.getStats();
    return dto.toDomain();
  }
}