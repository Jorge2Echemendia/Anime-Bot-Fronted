import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/stats.dart';

part 'stats_dto.freezed.dart';
part 'stats_dto.g.dart';

@freezed
class StatsDto with _$StatsDto {
  const factory StatsDto({
    required int totalUsers,
    required int bannedUsers,
    required int warnedUsers,
    required int totalWarnings,
  }) = _StatsDto;

  factory StatsDto.fromJson(Map<String, dynamic> json) =>
      _$StatsDtoFromJson(json);
}

extension StatsDtoMapper on StatsDto {
  Stats toDomain() => Stats(
        totalUsers: totalUsers,
        bannedUsers: bannedUsers,
        warnedUsers: warnedUsers,
        totalWarnings: totalWarnings,
      );
}