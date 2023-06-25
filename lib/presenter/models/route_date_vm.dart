import 'map_marker_vm.dart';

class RouteDateVM {
  // String dateTime;
  String subTitle;
  String timePickUp;
  String estTotalMiles;
  String estTotalPay;
  List<MapMarkerVM> listMarker;

  RouteDateVM(this.subTitle, this.timePickUp, this.estTotalMiles,
      this.estTotalPay, this.listMarker);
}