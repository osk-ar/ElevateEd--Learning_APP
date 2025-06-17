import 'package:ElevatED/features/data/models/course/course.dart';
import 'package:ElevatED/features/data/models/orderable/orderable.dart';
import 'package:ElevatED/features/domain/usecases/buy_course_usecase.dart';
import 'package:ElevatED/features/domain/usecases/get_course_by_id_usecase.dart';
import 'package:ElevatED/features/presentation/course_details/states/course_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  final GetCourseByIdUseCase getCourseByIdUseCase;
  final BuyCourseUseCase buyCourseUseCase;
  Course? course;
  bool isFavorite = false;

  CourseDetailsCubit(this.getCourseByIdUseCase, this.buyCourseUseCase)
      : super(CourseDetailsInitial());

  List<Orderable> get courseItems {
    if (course == null) return [];
    final items = <Orderable>[];
    items.addAll(course!.videos);
    items.addAll(course!.assignments);
    items.sort((a, b) => a.index.compareTo(b.index));
    return items;
  }

  Future<void> loadCourse(int courseId) async {
    emit(CourseDetailsLoading());
    // try {
    course = await getCourseByIdUseCase(courseId: courseId);
    emit(CourseDetailsLoaded(course: course!));
    // } catch (e) {
    //   emit(CourseDetailsError(e.toString()));
    // }
  }

  Future<void> buyCourse(int userId, int courseId) async {
    try {
      final paymentUrl = await buyCourseUseCase(
        userId: userId,
        courseId: courseId,
      );
      emit(CourseDetailsPaymentUrlReceived(paymentUrl: paymentUrl));
    } catch (e) {
      emit(CourseDetailsError(e.toString()));
    }
  }

  Future<void> launchPaymentUrl(String paymentUrl) async {
    final uri = Uri.parse(paymentUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
