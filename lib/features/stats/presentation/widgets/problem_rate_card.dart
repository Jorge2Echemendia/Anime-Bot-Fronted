import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/stats.dart';

class ProblemRateCard extends StatelessWidget {
  final Stats stats;
  const ProblemRateCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final percent = NumberFormat.percentPattern().format(stats.problemRate);
    final rate = stats.problemRate;
    final color = rate < 0.2
        ? Colors.green
        : rate < 0.5
            ? Colors.orange
            : Colors.red;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.insights, color: color),
                const SizedBox(width: 8),
                Text(
                  'Tasa de usuarios problemáticos',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              percent,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: rate.clamp(0.0, 1.0),
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
              color: color,
              backgroundColor: color.withOpacity(0.15),
            ),
            const SizedBox(height: 12),
            Text(
              rate < 0.2
                  ? 'El grupo está saludable ✅'
                  : rate < 0.5
                      ? 'Hay usuarios que requieren atención ⚠️'
                      : 'Se requiere moderación urgente 🚨',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}