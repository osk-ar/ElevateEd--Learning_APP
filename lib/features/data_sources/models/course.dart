class Course {
  final String title;
  final String description;
  final String instructor;
  final List<Lesson> lessons;

  Course({
    required this.title,
    required this.description,
    required this.instructor,
    required this.lessons,
  });
}

class Lesson {
  final String title;
  final String duration;

  Lesson({
    required this.title,
    required this.duration,
  });
}
