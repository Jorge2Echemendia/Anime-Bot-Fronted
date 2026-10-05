class Stats {
  final int totalUsers;
  final int bannedUsers;
  final int warnedUsers;
  final int totalWarnings;

  const Stats({
    required this.totalUsers,
    required this.bannedUsers,
    required this.warnedUsers,
    required this.totalWarnings,
  });

  double get problemRate {
    if (totalUsers == 0) return 0;
    return (warnedUsers + bannedUsers) / totalUsers;
  }

  bool get isEmpty => totalUsers == 0;
}