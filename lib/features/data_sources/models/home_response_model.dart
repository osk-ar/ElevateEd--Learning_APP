class HomeResponseModel {
  String userName;
  int totalCourses;
  int totalLearningTime;
  int todayLearningHours;
  Map<String, int> learningHoursDataPoints;

  HomeResponseModel({
    required this.userName,
    required this.totalCourses,
    required this.totalLearningTime,
    required this.todayLearningHours,
    required this.learningHoursDataPoints,
  });

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) {
    return HomeResponseModel(
      userName: json['userName'],
      totalCourses: json['totalCourses'],
      totalLearningTime: json['totalHours'],
      todayLearningHours: json['recentHours'],
      learningHoursDataPoints: json['last3Days'],
    );
  }
}
