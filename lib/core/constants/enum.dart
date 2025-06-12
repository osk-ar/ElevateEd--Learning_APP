enum ThemeEnum { light, dark, system }

enum LanguageEnum { en, ar }

enum NotificationStatusEnum { off, on }

enum UserRoleEnum { instructor, student }

enum ChartRangeEnum {
  week,
  month,
  year;

  String get title {
    switch (this) {
      case ChartRangeEnum.week:
        return 'Week';
      case ChartRangeEnum.month:
        return 'Month';
      case ChartRangeEnum.year:
        return 'Year';
    }
  }
}

enum Interests {
  webDev,
  flutter,
  oop,
  graphicDesign,
  mobileDev,
  modeling3D,
}

enum MediaType {
  file,
  video,
  image,
}

enum CourseStatusEnum {
  uploaded,
  pending;

  String get title {
    switch (this) {
      case CourseStatusEnum.uploaded:
        return 'Uploaded';
      case CourseStatusEnum.pending:
        return 'Pending';
    }
  }
}
