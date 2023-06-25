import 'package:driver/presenter/models/availability_day_vm.dart';

class AvailabilityEvent {
 const AvailabilityEvent();
}

class AvailabilityLoadList extends AvailabilityEvent{
  const AvailabilityLoadList();
}

class AvailabilityLoadMore extends AvailabilityEvent {
  const AvailabilityLoadMore();
}

class AvailabilityRefresh extends AvailabilityEvent {
  const AvailabilityRefresh();
}

class AvailabilityFillCurrentSelected extends AvailabilityEvent {
  final AvailableType availableType;
  final String note;
  const AvailabilityFillCurrentSelected(this.availableType, this.note);
}

