import 'package:tutor_search_system/models/notification.dart';

abstract class NotificationState {}

class InitialNotificationState extends NotificationState {}

class NotificationErrorState extends NotificationState {
  final String errorMessage;

  NotificationErrorState(this.errorMessage);
}

class NotificationLoadedState extends NotificationState {
  final Notification notification;

  NotificationLoadedState(this.notification);
}

class NotificationListLoadedState extends NotificationState {
  final List<Notification> notifications;

  NotificationListLoadedState(this.notifications);
}

class NotificationNoDataState extends NotificationState {}
