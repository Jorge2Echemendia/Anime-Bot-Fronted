import 'package:anime_bot_fronted/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/global_providers.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../domain/entities/admin.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/login_use_case.dart';

// Data source
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(ref.watch(apiClientProvider));
});

// Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.watch(authRemoteDataSourceProvider),
    ref.watch(secureStorageProvider),
  );
});

// Use cases
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

// Estado de autenticación
class AuthState {
  final Admin? admin;
  final bool isLoading;
  final String? error;

  const AuthState({this.admin, this.isLoading = false, this.error});

  AuthState copyWith({Admin? admin, bool? isLoading, String? error}) {
    return AuthState(
      admin: admin ?? this.admin,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final AuthRepository _repository;

  AuthNotifier(this._loginUseCase, this._repository)
      : super(const AuthState()) {
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    final admin = await _repository.getCurrentAdmin();
    if (admin != null) state = state.copyWith(admin: admin);
  }

  Future<bool> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final admin = await _loginUseCase(username, password);
      state = AuthState(admin: admin);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState();
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.watch(loginUseCaseProvider),
    ref.watch(authRepositoryProvider),
  );
});