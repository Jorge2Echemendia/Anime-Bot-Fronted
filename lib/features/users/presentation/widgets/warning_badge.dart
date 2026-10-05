import 'package:flutter/material.dart';

class WarningBadge extends StatelessWidget {
  final int warnings;
  final bool isBanned;
  const WarningBadge({super.key, required this.warnings, required this.isBanned});

  @override
  Widget build(BuildContext context) {
    final (color, icon) = _resolveBadge();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 4),
          Text(
            isBanned ? 'Ban' : '$warnings/3',
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  (Color, IconData) _resolveBadge() {
    if (isBanned) return (Colors.red, Icons.block);
    if (warnings >= 2) return (Colors.orange, Icons.warning_amber);
    if (warnings == 1) return (Colors.amber, Icons.info_outline);
    return (Colors.green, Icons.check_circle_outline);
  }
}