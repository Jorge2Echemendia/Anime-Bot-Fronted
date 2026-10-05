class User {
  final String id;
  final String username;
  final int warnings;
  final bool isBanned;

  const User({
    required this.id,
    required this.username,
    required this.warnings,
    required this.isBanned,
  });

  bool get isAtRisk => warnings >= 2 && !isBanned;
}