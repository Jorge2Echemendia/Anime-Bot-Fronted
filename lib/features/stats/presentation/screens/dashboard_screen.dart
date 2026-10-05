import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/stats.dart';
import '../providers/stats_providers.dart';
import '../widgets/stat_card.dart';
import '../widgets/problem_rate_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(statsProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(statsProvider),
        child: statsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => _ErrorView(
            error: err.toString(),
            onRetry: () => ref.invalidate(statsProvider),
          ),
          data: (stats) => _DashboardContent(stats: stats),
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final Stats stats;
  const _DashboardContent({required this.stats});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Resumen del grupo',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;
            final cards = [
              StatCard(
                icon: Icons.people_outline,
                label: 'Usuarios',
                value: stats.totalUsers.toString(),
                color: Colors.blue,
              ),
              StatCard(
                icon: Icons.warning_amber,
                label: 'Advertidos',
                value: stats.warnedUsers.toString(),
                color: Colors.orange,
              ),
              StatCard(
                icon: Icons.block,
                label: 'Baneados',
                value: stats.bannedUsers.toString(),
                color: Colors.red,
              ),
              StatCard(
                icon: Icons.report_problem,
                label: 'Total advertencias',
                value: stats.totalWarnings.toString(),
                color: Colors.purple,
              ),
            ];

            if (isWide) {
              return GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.4,
                children: cards,
              );
            }
            return GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: cards,
            );
          },
        ),
        const SizedBox(height: 24),
        ProblemRateCard(stats: stats),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;
  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 80),
        const Icon(Icons.error_outline, size: 64, color: Colors.red),
        const SizedBox(height: 16),
        Center(child: Text('Error: $error')),
        const SizedBox(height: 16),
        Center(
          child: FilledButton(
            onPressed: onRetry,
            child: const Text('Reintentar'),
          ),
        ),
      ],
    );
  }
}