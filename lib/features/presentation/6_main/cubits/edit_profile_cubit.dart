import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../states/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  Future<void> saveProfile() async {
    try {
      emit(EditProfileSaving());
      // TODO: call repository to save profile
      await Future.delayed(const Duration(seconds: 1));
      emit(EditProfileSaved());
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }
}
