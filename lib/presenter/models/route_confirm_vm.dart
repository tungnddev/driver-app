import 'package:flutter/material.dart';

class RouteConfirmVM {
  String code;
  String customerName;
  String customerPhone;
  String address;
  DateTime timeDrop;

  RouteConfirmVM(this.code, this.customerName, this.customerPhone, this.address,
      this.timeDrop);
}