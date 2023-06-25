import 'package:driver/data/remote/exception/app_exception.dart';
import 'package:driver/presenter/models/notification_vm.dart';

class NotificationState {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

class NotificationLoadSuccessful extends NotificationState {
  final List<NotificationVM?> listNotification;

  const NotificationLoadSuccessful({required this.listNotification});
}

class NotificationLoading extends NotificationState {}

class NotificationLoadFailed extends NotificationState {
  final AppException error;

  const NotificationLoadFailed({required this.error});
}

class NotificationLoadEmpty extends NotificationState{
  const NotificationLoadEmpty();
}