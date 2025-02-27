import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/features/data_sources/local/disk_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'package:ElevatED/features/presentation/settings/states/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this._diskCache)
      : super(const NotificationInitial(Notifications.on)) {
    final int? notificationMode = _diskCache.getNotificationsMode();
    if (notificationMode != null) {
      emit(NotificationChanged(Notifications.values[notificationMode]));
    }
  }
  final DiskCache _diskCache;

  void changeNotificationMode(
      BuildContext context, Notifications notifications) {
    _diskCache.saveNotificationMode(notifications);
    emit(NotificationChanged(notifications));
  }
}
