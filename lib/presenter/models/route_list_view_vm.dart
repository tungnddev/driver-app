import 'dart:ui';

class RouteListViewVM {
  String subTitle;
  String timePickUp;
  String estTotalMiles;
  String estTotalPay;
  List<RouteListViewItemVM> items;

  RouteListViewVM(this.subTitle, this.timePickUp, this.estTotalMiles,
      this.estTotalPay, this.items);
}

class RouteListViewItemVM {
  String title;
  String customerName;
  String customerPhone;
  String address;
  String timeLine;
  String status;
  Color colorStatus;
  Color bgColor;
  Color colorTextStatus;

  RouteListViewItemVM(this.title, this.customerName, this.customerPhone, this.address, this.timeLine, this.status, this.colorStatus, this.bgColor, this.colorTextStatus);
}