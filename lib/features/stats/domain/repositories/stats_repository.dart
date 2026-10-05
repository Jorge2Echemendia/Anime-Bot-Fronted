import '../entities/stats.dart';

abstract interface class StatsRepository {
  Future<Stats> getStats();
}