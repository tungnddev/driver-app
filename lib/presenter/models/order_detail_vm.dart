import 'dart:ui';

class OrderDetailVM {
  String title;
  String status;
  Color bgColor;
  Color colorStatus;
  Color colorTextStatus;
  String customerName;
  String customerPhone;
  String location;
  String rentalDateFrom;
  String rentalDateTo;
  String estDropOff;
  String estPickUp;
  String specialInstructions;
  List<OrderDetailItemVM> orderItems;
  List<OrderLineFeeVM> fee;
  OrderTransitionVM orderTransition;

  OrderDetailVM(
      this.title,
      this.status,
      this.bgColor,
      this.colorStatus,
      this.colorTextStatus,
      this.customerName,
      this.customerPhone,
      this.rentalDateFrom,
      this.rentalDateTo,
      this.location,
      this.estDropOff,
      this.estPickUp,
      this.specialInstructions,
      this.orderItems,
      this.fee,
      this.orderTransition);
}

class OrderDetailItemVM {
  String title;
  String description;
  String quantity;
  String unitPrice;
  String total;

  OrderDetailItemVM(
      this.title, this.description, this.quantity, this.unitPrice, this.total);
}

class OrderTransitionVM {
  String time;
  String fee;
  String method;

  OrderTransitionVM(this.time, this.fee, this.method);

}

class OrderLineFeeVM {
  String title;
  String fee;
  bool isBold;
  OrderLineFeeVM(this.title, this.fee, {this.isBold = false});
}