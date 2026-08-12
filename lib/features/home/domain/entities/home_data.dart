class HomeData {
  final int streakDays;
  final int? elapsedTimeToday;
  final DateTime? lastCompletedDate;
  final DateTime? lastActiveDate;

  HomeData({
    required this.streakDays,
    required this.elapsedTimeToday,
    this.lastCompletedDate,
    required this.lastActiveDate,
  });
}
