import '../entities/stats.dart';
import '../repositories/stats_repository.dart';

class GetStatsUseCase {
  final StatsRepository _repository;
  GetStatsUseCase(this._repository);

  Future<Stats> call() => _repository.getStats();
}