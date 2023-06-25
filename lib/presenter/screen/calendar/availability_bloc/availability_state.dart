import 'package:driver/data/remote/exception/app_exception.dart';
import 'package:driver/presenter/models/availability_day_vm.dart';
import 'package:driver/presenter/models/pending_confirm_vm.dart';
import 'package:driver/presenter/models/route_confirm_vm.dart';

class AvailabilityState {
  const AvailabilityState();
}

class AvailabilityInitial extends AvailabilityState {
  const AvailabilityInitial();
}

class AvailabilityLoadSuccessful extends AvailabilityState {
  final List<AvailabilityVM?> listAvailability;

  const AvailabilityLoadSuccessful({required this.listAvailability});
}

class AvailabilityLoading extends AvailabilityState {}

class AvailabilityLoadFailed extends AvailabilityState {
  final AppException error;

  const AvailabilityLoadFailed({required this.error});
}

class AvailabilityLoadEmpty extends AvailabilityState{
  const AvailabilityLoadEmpty();
}