import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';
import 'package:ElevatED/features/data/models/data_point.dart';
import 'package:ElevatED/features/data/models/orderable/orderable.dart';
import 'package:ElevatED/features/data/models/view/normalized_course.dart';
import 'package:ElevatED/features/data/models/user_data.dart';

class MemoryCache {
  MemoryCache._();

//------------------------------------
  // User Data
  static int? _id;
  static UserRoleEnum? _userRole;
  static String? _fullName;
  static String? _email;
  static String? _password;
  static String? _phone;
  static String? _birthDate;
  static UserData? _userData;
  static UserData? _visitedUserData;
  static List<CourseCategory> _categories = [];
  static List<NormalizedCourse> _allCourses = [];
  static List<Orderable>? _currentCourseItems;
  static int? _currentCourseItemIndex;

  static String? _resetPasswordEmail;

  static void pushResetPasswordEmail(String email) =>
      _resetPasswordEmail = email;

  static String? getResetPasswordEmail() => _resetPasswordEmail;

  static void clearResetPasswordEmail() => _resetPasswordEmail = null;

  static void pushId(int id) => _id = id;

  static void pushEmail(String email) => _email = email;

  static void pushPassword(String password) => _password = password;

  static void pushUserRole(UserRoleEnum userRole) => _userRole = userRole;

  static void pushFullName(String firstName) => _fullName = firstName;

  static void pushBirthDate(String birthDate) => _birthDate = birthDate;

  static void pushPhone(String phone) => _phone = phone;

  static void pushUserData(UserData userData) => _userData = userData;

  static void pushVisitedUserData(UserData userData) =>
      _visitedUserData = userData;

  static void pushCategories(List<CourseCategory> categories) =>
      _categories = categories;

  static int? getId() => _id;

  static String? getEmail() => _email;

  static String? getPassword() => _password;

  static UserRoleEnum? getUserRole() => _userRole;

  static String? getFullName() => _fullName;

  static String? getPhone() => _phone;

  static String? getBirthDate() => _birthDate;

  static UserData? getUserData() => _userData;
  static UserData? getVisitedUserData() => _visitedUserData;
  static List<CourseCategory> getCategories() => _categories;

  static List<NormalizedCourse> getAllCourses() => _allCourses;
  static void pushAllCourses(List<NormalizedCourse> courses) =>
      _allCourses = courses;
  static void clearAllCourses() => _allCourses = [];

  static void pushCurrentCourseItems(List<Orderable> items) =>
      _currentCourseItems = items;

  static void pushCurrentCourseItemIndex(int index) =>
      _currentCourseItemIndex = index;

  static List<Orderable>? getCurrentCourseItems() => _currentCourseItems;
  static int? getCurrentCourseItemIndex() => _currentCourseItemIndex;
  static void clearCurrentCourseItems() {
    _currentCourseItems = null;
    _currentCourseItemIndex = null;
  }

//------------------------------------
  static void pushRegisterData(Map<String, dynamic> registerModel) {
    MemoryCache.pushUserRole(registerModel['role']!);
    MemoryCache.pushEmail(registerModel['email']!);
    MemoryCache.pushPassword(registerModel['password']!);
    MemoryCache.pushFullName(registerModel['fullName']!);
    MemoryCache.pushPhone(registerModel['phone']!);
    MemoryCache.pushBirthDate(registerModel['birthDate']!);
  }

  static UserData staticUserData(UserRoleEnum role) {
    switch (role) {
      case UserRoleEnum.student:
        return StudentUserData(
          id: 3,
          name: "zeiad",
          email: "zeiad123@gmail.com",
          phone: "01012345641",
          token:
              "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJvcmVtb285OUBnbWFpbC5jb20iLCJpYXQiOjE3NDk2NzQyODUsImV4cCI6MTc0OTc2MDY4NX0.ryE9o2fXXfzW6bRQ4uuC2O4h14hvfQbPHeTgr5UTHmM",
          profilePictureUrl: "/images/zeiad.png",
          role: role,
          description: "my student description",
          dateOfBirth: DateTime.now(),
          interests: [
            CourseCategory(id: 1, name: "programming"),
            CourseCategory(id: 2, name: "Digital Design"),
          ],
          purchasedCourses: [
            NormalizedCourse(
                id: 1,
                category: CourseCategory(id: 1, name: "programming"),
                title: "static course name",
                instructorName: "zeiad the instructor",
                rating: 3.6,
                instructorId: 1,
                description: "static course description",
                price: 100),
          ],
          activityPoints: [
            DataPoint(
                value: 3,
                dateTime: DateTime.now().add(const Duration(days: 1))),
            DataPoint(
                value: 9.4,
                dateTime: DateTime.now().add(const Duration(days: 2))),
            DataPoint(
                value: 12,
                dateTime: DateTime.now().add(const Duration(days: 3))),
          ],
        );

      case UserRoleEnum.instructor:
        return InstructorUserData(
            id: 2,
            name: "zeiad",
            email: "zeiad123@gmail.com",
            phone: "01012345641",
            token:
                "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJvcmVtb285OUBnbWFpbC5jb20iLCJpYXQiOjE3NDk2NzQyODUsImV4cCI6MTc0OTc2MDY4NX0.ryE9o2fXXfzW6bRQ4uuC2O4h14hvfQbPHeTgr5UTHmM",
            profilePictureUrl: "/images/zeiad.png",
            role: role,
            description: "my student description",
            dateOfBirth: DateTime.now(),
            expertise: [
              CourseCategory(id: 1, name: "programming"),
              CourseCategory(id: 2, name: "Digital Design"),
            ],
            createdCourses: [
              NormalizedCourse(
                  id: 1,
                  category: CourseCategory(id: 1, name: "programming"),
                  title: "static course name",
                  instructorName: "zeiad the instructor",
                  rating: 3.6,
                  instructorId: 1,
                  description: "static course description",
                  price: 100),
            ],
            purchasedCourses: [],
            revenuePoints: [
              DataPoint(
                  value: 3,
                  dateTime: DateTime.now().add(const Duration(days: 1))),
              DataPoint(
                  value: 9.4,
                  dateTime: DateTime.now().add(const Duration(days: 2))),
              DataPoint(
                  value: 12,
                  dateTime: DateTime.now().add(const Duration(days: 3))),
            ],
            personalLinks: [],
            professionalTitle: "zeiad the instructor title",
            totalStudents: 67);
    }
  }

  static void clearUserData() => _userData = null;
}
