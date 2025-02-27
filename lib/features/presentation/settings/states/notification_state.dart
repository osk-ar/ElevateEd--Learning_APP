part of 'package:ElevatED/features/presentation/settings/cubits/notifications_cubit.dart';

class NotificationState extends Equatable {
  const NotificationState(this.notifications);
  final Notifications notifications;

  @override
  List<Object?> get props => [notifications];
}

class NotificationInitial extends NotificationState {
  const NotificationInitial(super.notifications);

  @override
  List<Object?> get props => [notifications];
}

class NotificationChanged extends NotificationState {
  const NotificationChanged(super.notifications);

  @override
  List<Object?> get props => [notifications];
}
