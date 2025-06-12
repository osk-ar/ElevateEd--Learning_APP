import 'package:ElevatED/core/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'package:ElevatED/features/presentation/settings/states/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit()
      : super(const NotificationInitial(NotificationStatusEnum.on));

  void changeNotificationMode(
      BuildContext context, NotificationStatusEnum notifications) {
    emit(NotificationChanged(notifications));
  }
}
// todo edit after adding notification service
