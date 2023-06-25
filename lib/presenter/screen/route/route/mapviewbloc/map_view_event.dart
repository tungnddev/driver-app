import 'package:driver/presenter/models/route_date_vm.dart';

class MapViewEvent {

}

class MapViewStartLoad extends MapViewEvent {
  final DateTime dateSelected;
  MapViewStartLoad(this.dateSelected);
}

class MapViewLoadImageSuccess extends MapViewEvent {
  final RouteDateVM vm;
  MapViewLoadImageSuccess(this.vm);
}