import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/domain/usecases/get_visited_profile_usecase.dart';
import 'package:url_launcher/url_launcher.dart';

part '../states/visit_profile_state.dart';

class VisitProfileCubit extends Cubit<VisitProfileState> {
  final GetVisitedProfileUseCase _getVisitProfile;
  VisitProfileCubit(this._getVisitProfile) : super(VisitProfileInitial());

  Future<void> loadProfile(int userId) async {
    try {
      emit(VisitProfileLoading());
      final profile = await _getVisitProfile.call(userId);
      emit(VisitProfileLoaded(profile));
    } catch (e) {
      emit(VisitProfileError(e.toString()));
    }
  }

  Future<void> launchSocialLink(String? url) async {
    if (url == null || url.isEmpty) {
      emit(const VisitProfileError('No URL provided'));
      return;
    }

    try {
      final uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        emit(VisitProfileError('Could not launch $url'));
      }
    } catch (e) {
      emit(VisitProfileError('Invalid URL: $url'));
    }
  }
}
