class Home {
  String userName;
  int totalCourses;
  int totalLearningTime;
  int todayLearningHours;
  Map<String, int> learningHoursDataPoints;

  Home({
    required this.userName,
    required this.totalCourses,
    required this.totalLearningTime,
    required this.todayLearningHours,
    required this.learningHoursDataPoints,
  });
}
