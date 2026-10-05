// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StatsDtoImpl _$$StatsDtoImplFromJson(Map<String, dynamic> json) =>
    _$StatsDtoImpl(
      totalUsers: (json['totalUsers'] as num).toInt(),
      bannedUsers: (json['bannedUsers'] as num).toInt(),
      warnedUsers: (json['warnedUsers'] as num).toInt(),
      totalWarnings: (json['totalWarnings'] as num).toInt(),
    );

Map<String, dynamic> _$$StatsDtoImplToJson(_$StatsDtoImpl instance) =>
    <String, dynamic>{
      'totalUsers': instance.totalUsers,
      'bannedUsers': instance.bannedUsers,
      'warnedUsers': instance.warnedUsers,
      'totalWarnings': instance.totalWarnings,
    };
