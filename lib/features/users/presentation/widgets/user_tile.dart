import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import 'warning_badge.dart';

class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const UserTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _avatarColor(context),
        child: Text(user.username.substring(0, 1).toUpperCase()),
      ),
      title: Text('@${user.username}'),
      subtitle: user.isBanned
          ? const Text('Baneado', style: TextStyle(color: Colors.red))
          : Text('${user.warnings}/3 advertencias'),
      trailing: WarningBadge(warnings: user.warnings, isBanned: user.isBanned),
      onTap: onTap,
    );
  }

  Color _avatarColor(BuildContext context) {
    if (user.isBanned) return Colors.red.shade100;
    if (user.isAtRisk) return Colors.orange.shade100;
    return Theme.of(context).colorScheme.primaryContainer;
  }
}