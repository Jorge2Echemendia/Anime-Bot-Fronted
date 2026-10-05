// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stats_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StatsDto _$StatsDtoFromJson(Map<String, dynamic> json) {
  return _StatsDto.fromJson(json);
}

/// @nodoc
mixin _$StatsDto {
  int get totalUsers => throw _privateConstructorUsedError;
  int get bannedUsers => throw _privateConstructorUsedError;
  int get warnedUsers => throw _privateConstructorUsedError;
  int get totalWarnings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatsDtoCopyWith<StatsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatsDtoCopyWith<$Res> {
  factory $StatsDtoCopyWith(StatsDto value, $Res Function(StatsDto) then) =
      _$StatsDtoCopyWithImpl<$Res, StatsDto>;
  @useResult
  $Res call(
      {int totalUsers, int bannedUsers, int warnedUsers, int totalWarnings});
}

/// @nodoc
class _$StatsDtoCopyWithImpl<$Res, $Val extends StatsDto>
    implements $StatsDtoCopyWith<$Res> {
  _$StatsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalUsers = null,
    Object? bannedUsers = null,
    Object? warnedUsers = null,
    Object? totalWarnings = null,
  }) {
    return _then(_value.copyWith(
      totalUsers: null == totalUsers
          ? _value.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      bannedUsers: null == bannedUsers
          ? _value.bannedUsers
          : bannedUsers // ignore: cast_nullable_to_non_nullable
              as int,
      warnedUsers: null == warnedUsers
          ? _value.warnedUsers
          : warnedUsers // ignore: cast_nullable_to_non_nullable
              as int,
      totalWarnings: null == totalWarnings
          ? _value.totalWarnings
          : totalWarnings // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatsDtoImplCopyWith<$Res>
    implements $StatsDtoCopyWith<$Res> {
  factory _$$StatsDtoImplCopyWith(
          _$StatsDtoImpl value, $Res Function(_$StatsDtoImpl) then) =
      __$$StatsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalUsers, int bannedUsers, int warnedUsers, int totalWarnings});
}

/// @nodoc
class __$$StatsDtoImplCopyWithImpl<$Res>
    extends _$StatsDtoCopyWithImpl<$Res, _$StatsDtoImpl>
    implements _$$StatsDtoImplCopyWith<$Res> {
  __$$StatsDtoImplCopyWithImpl(
      _$StatsDtoImpl _value, $Res Function(_$StatsDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalUsers = null,
    Object? bannedUsers = null,
    Object? warnedUsers = null,
    Object? totalWarnings = null,
  }) {
    return _then(_$StatsDtoImpl(
      totalUsers: null == totalUsers
          ? _value.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      bannedUsers: null == bannedUsers
          ? _value.bannedUsers
          : bannedUsers // ignore: cast_nullable_to_non_nullable
              as int,
      warnedUsers: null == warnedUsers
          ? _value.warnedUsers
          : warnedUsers // ignore: cast_nullable_to_non_nullable
              as int,
      totalWarnings: null == totalWarnings
          ? _value.totalWarnings
          : totalWarnings // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatsDtoImpl implements _StatsDto {
  const _$StatsDtoImpl(
      {required this.totalUsers,
      required this.bannedUsers,
      required this.warnedUsers,
      required this.totalWarnings});

  factory _$StatsDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatsDtoImplFromJson(json);

  @override
  final int totalUsers;
  @override
  final int bannedUsers;
  @override
  final int warnedUsers;
  @override
  final int totalWarnings;

  @override
  String toString() {
    return 'StatsDto(totalUsers: $totalUsers, bannedUsers: $bannedUsers, warnedUsers: $warnedUsers, totalWarnings: $totalWarnings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatsDtoImpl &&
            (identical(other.totalUsers, totalUsers) ||
                other.totalUsers == totalUsers) &&
            (identical(other.bannedUsers, bannedUsers) ||
                other.bannedUsers == bannedUsers) &&
            (identical(other.warnedUsers, warnedUsers) ||
                other.warnedUsers == warnedUsers) &&
            (identical(other.totalWarnings, totalWarnings) ||
                other.totalWarnings == totalWarnings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, totalUsers, bannedUsers, warnedUsers, totalWarnings);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatsDtoImplCopyWith<_$StatsDtoImpl> get copyWith =>
      __$$StatsDtoImplCopyWithImpl<_$StatsDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatsDtoImplToJson(
      this,
    );
  }
}

abstract class _StatsDto implements StatsDto {
  const factory _StatsDto(
      {required final int totalUsers,
      required final int bannedUsers,
      required final int warnedUsers,
      required final int totalWarnings}) = _$StatsDtoImpl;

  factory _StatsDto.fromJson(Map<String, dynamic> json) =
      _$StatsDtoImpl.fromJson;

  @override
  int get totalUsers;
  @override
  int get bannedUsers;
  @override
  int get warnedUsers;
  @override
  int get totalWarnings;
  @override
  @JsonKey(ignore: true)
  _$$StatsDtoImplCopyWith<_$StatsDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
