import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/global_providers.dart';
import '../../data/datasources/user_remote_data_source.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/use_cases/get_user_use_case.dart';
import '../../domain/use_cases/list_users_use_case.dart';
import '../../domain/use_cases/unban_user_use_case.dart';
import '../../domain/use_cases/warn_user_use_case.dart';

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  return UserRemoteDataSource(ref.watch(apiClientProvider));
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(ref.watch(userRemoteDataSourceProvider));
});

final listUsersUseCaseProvider = Provider<ListUsersUseCase>((ref) {
  return ListUsersUseCase(ref.watch(userRepositoryProvider));
});

final getUserUseCaseProvider = Provider<GetUserUseCase>((ref) {
  return GetUserUseCase(ref.watch(userRepositoryProvider));
});

final warnUserUseCaseProvider = Provider<WarnUserUseCase>((ref) {
  return WarnUserUseCase(ref.watch(userRepositoryProvider));
});

final unbanUserUseCaseProvider = Provider<UnbanUserUseCase>((ref) {
  return UnbanUserUseCase(ref.watch(userRepositoryProvider));
});

// Lista de usuarios (con invalidación)
final usersListProvider = FutureProvider<List<User>>((ref) async {
  final useCase = ref.watch(listUsersUseCaseProvider);
  return useCase();
});

// Detalle de usuario
final userDetailProvider =
    FutureProvider.family<User, String>((ref, userId) async {
  final useCase = ref.watch(getUserUseCaseProvider);
  return useCase(userId);
});