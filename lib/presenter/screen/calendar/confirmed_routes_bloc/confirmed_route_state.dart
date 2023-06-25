import 'package:driver/data/remote/exception/app_exception.dart';
import 'package:driver/presenter/models/route_confirm_vm.dart';

class ConfirmedRouteState {
  const ConfirmedRouteState();
}

class ConfirmedRouteInitial extends ConfirmedRouteState {
  const ConfirmedRouteInitial();
}

class ConfirmedRouteLoadSuccessful extends ConfirmedRouteState {
  final List<RouteConfirmVM?> listConfirmedRoute;

  const ConfirmedRouteLoadSuccessful({required this.listConfirmedRoute});
}

class ConfirmedRouteLoading extends ConfirmedRouteState {}

class ConfirmedRouteLoadFailed extends ConfirmedRouteState {
  final AppException error;

  const ConfirmedRouteLoadFailed({required this.error});
}

class ConfirmedRouteLoadEmpty extends ConfirmedRouteState{
  const ConfirmedRouteLoadEmpty();
}