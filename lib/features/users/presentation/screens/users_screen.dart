import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/loading_overlay.dart';
import '../providers/user_providers.dart';
import '../widgets/user_tile.dart';

class UsersScreen extends ConsumerWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(usersListProvider),
          ),
        ],
      ),
      body: usersAsync.when(
        loading: () => const LoadingOverlay(),
        error: (err, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 8),
              Text('Error: $err'),
              TextButton(
                onPressed: () => ref.invalidate(usersListProvider),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
        data: (users) {
          if (users.isEmpty) {
            return const Center(child: Text('No hay usuarios registrados'));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(usersListProvider),
            child: ListView.separated(
              itemCount: users.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final user = users[index];
                return UserTile(
                  user: user,
                  onTap: () => context.push('/users/${user.id}'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}