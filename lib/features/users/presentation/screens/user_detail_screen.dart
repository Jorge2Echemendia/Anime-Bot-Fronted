import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_providers.dart';

class UserDetailScreen extends ConsumerWidget {
  final String userId;
  const UserDetailScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userDetailProvider(userId));

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de Usuario')),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (user) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: ListTile(
                  title: Text('@${user.username}'),
                  subtitle: Text('ID: ${user.id}'),
                  trailing: Chip(
                    label: Text(user.isBanned ? 'Baneado' : 'Activo'),
                    backgroundColor: user.isBanned
                        ? Colors.red.shade100
                        : Colors.green.shade100,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        '${user.warnings}/3 advertencias',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: user.warnings / 3,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                        color: user.warnings >= 2 ? Colors.red : Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (!user.isBanned)
                FilledButton.icon(
                  icon: const Icon(Icons.warning_amber),
                  label: const Text('Añadir advertencia'),
                  onPressed: () => _showWarnDialog(context, ref, user.id),
                ),
              if (user.isBanned) ...[
                const SizedBox(height: 8),
                FilledButton.icon(
                  icon: const Icon(Icons.lock_open),
                  label: const Text('Desbanear'),
                  onPressed: () => _unban(context, ref, user.id),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showWarnDialog(
    BuildContext context,
    WidgetRef ref,
    String userId,
  ) async {
    final controller = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Motivo de la advertencia'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Ej: Spam'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Advertir'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await ref.read(warnUserUseCaseProvider)(userId, controller.text);
      ref.invalidate(userDetailProvider(userId));
      ref.invalidate(usersListProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Advertencia añadida')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _unban(BuildContext context, WidgetRef ref, String userId) async {
    try {
      await ref.read(unbanUserUseCaseProvider)(userId);
      ref.invalidate(userDetailProvider(userId));
      ref.invalidate(usersListProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario desbaneado')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}