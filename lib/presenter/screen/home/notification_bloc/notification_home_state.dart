import 'package:driver/data/remote/exception/app_exception.dart';
import 'package:driver/presenter/models/notification_home_vm.dart';

class NotificationHomeState {

}

class NotificationHomeInitial extends NotificationHomeState {

}

class NotificationHomeLoading extends NotificationHomeState{

}

class NotificationHomeLoadSuccess extends NotificationHomeState {
  List<NotificationHomeVM> list;
  NotificationHomeLoadSuccess({required this.list});
}

class NotificationHomeLoadError extends NotificationHomeState {
  AppException appException;
  NotificationHomeLoadError({required this.appException});
}