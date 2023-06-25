import 'package:driver/presenter/models/route_date_vm.dart';

class MapViewState {

}

class MapViewInitial extends MapViewState {

}

class MapViewLoadSuccessful extends MapViewState {
  RouteDateVM vm;
  MapViewLoadSuccessful(this.vm);
}

class MapViewLoading extends MapViewState {
}