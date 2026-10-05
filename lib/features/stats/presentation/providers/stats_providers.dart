import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/global_providers.dart';
import '../../data/datasources/stats_remote_data_source.dart';
import '../../data/repositories/stats_repository_impl.dart';
import '../../domain/entities/stats.dart';
import '../../domain/repositories/stats_repository.dart';
import '../../domain/use_cases/get_stats_use_case.dart';

final statsRemoteDataSourceProvider = Provider<StatsRemoteDataSource>((ref) {
  return StatsRemoteDataSource(ref.watch(apiClientProvider));
});

final statsRepositoryProvider = Provider<StatsRepository>((ref) {
  return StatsRepositoryImpl(ref.watch(statsRemoteDataSourceProvider));
});

final getStatsUseCaseProvider = Provider<GetStatsUseCase>((ref) {
  return GetStatsUseCase(ref.watch(statsRepositoryProvider));
});

final statsProvider = FutureProvider<Stats>((ref) async {
  return ref.watch(getStatsUseCaseProvider)();
});