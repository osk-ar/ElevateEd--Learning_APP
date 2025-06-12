import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/domain/usecases/get_user_profile_usecase.dart';

part '../states/visit_profile_state.dart';

class VisitProfileCubit extends Cubit<VisitProfileState> {
  final GetUserProfileUseCase _getUserProfile;
  VisitProfileCubit(this._getUserProfile) : super(VisitProfileInitial());

  Future<void> loadProfile(int userId) async {
    try {
      emit(VisitProfileLoading());
      final profile = await _getUserProfile.call(userId);
      emit(VisitProfileLoaded(profile));
    } catch (e) {
      emit(VisitProfileError(e.toString()));
    }
  }
}
