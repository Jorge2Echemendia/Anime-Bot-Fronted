import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';

class AppScaffold extends ConsumerWidget {
  final Widget child;
  final String currentLocation;
  const AppScaffold({
    super.key,
    required this.child,
    required this.currentLocation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final admin = ref.watch(authNotifierProvider).admin;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión (${admin?.username ?? ""})',
            onPressed: () => ref.read(authNotifierProvider.notifier).logout(),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.shield, size: 40),
                  const SizedBox(height: 8),
                  Text('@${admin?.username ?? ""}'),
                ],
              ),
            ),
            _DrawerItem(
              icon: Icons.dashboard,
              label: 'Dashboard',
              route: '/dashboard',
              current: currentLocation,
            ),
            _DrawerItem(
              icon: Icons.people,
              label: 'Usuarios',
              route: '/users',
              current: currentLocation,
            ),
            _DrawerItem(
              icon: Icons.campaign,
              label: 'Difundir mensaje',
              route: '/broadcast',
              current: currentLocation,
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final String current;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    final selected = current.startsWith(route);
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      selected: selected,
      onTap: () {
        Navigator.pop(context); // Cerrar drawer
        context.go(route);
      },
    );
  }
}