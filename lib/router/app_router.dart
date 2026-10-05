import 'package:anime_bot_fronted/messages/data/presentation/screens/broadcast_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/providers/auth_providers.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/stats/presentation/screens/dashboard_screen.dart';
import '../features/users/presentation/screens/user_detail_screen.dart';
import '../features/users/presentation/screens/users_screen.dart';
import '../shared/widgets/app_scaffold.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/dashboard',
    redirect: (context, state) {
      final isLoggedIn = authState.admin != null;
      final isOnLogin = state.matchedLocation == '/login';

      if (!isLoggedIn && !isOnLogin) return '/login';
      if (isLoggedIn && isOnLogin) return '/dashboard';
      return null;
    },
    refreshListenable: _AuthListenable(ref),
    routes: [
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) =>
            AppScaffold(currentLocation: state.matchedLocation, child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (_, __) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/users',
            builder: (_, __) => const UsersScreen(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (_, state) =>
                    UserDetailScreen(userId: state.pathParameters['id']!),
              ),
            ],
          ),
          GoRoute(
            path: '/broadcast',
            builder: (_, __) => const BroadcastScreen(),
          ),
        ],
      ),
    ],
  );
});

/// Adaptador para que GoRouter escuche cambios en Riverpod
class _AuthListenable extends ChangeNotifier {
  _AuthListenable(Ref ref) {
    ref.listen(authNotifierProvider, (_, __) => notifyListeners());
  }
}