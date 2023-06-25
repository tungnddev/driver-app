import 'package:driver/data/remote/exception/app_exception.dart';
import 'package:driver/presenter/models/pending_confirm_vm.dart';
import 'package:driver/presenter/models/route_confirm_vm.dart';

class PendingRouteState {
  const PendingRouteState();
}

class PendingRouteInitial extends PendingRouteState {
  const PendingRouteInitial();
}

class PendingRouteLoadSuccessful extends PendingRouteState {
  final List<PendingConfirmVM?> listPendingRoute;

  const PendingRouteLoadSuccessful({required this.listPendingRoute});
}

class PendingRouteLoading extends PendingRouteState {}

class PendingRouteLoadFailed extends PendingRouteState {
  final AppException error;

  const PendingRouteLoadFailed({required this.error});
}

class PendingRouteLoadEmpty extends PendingRouteState{
  const PendingRouteLoadEmpty();
}