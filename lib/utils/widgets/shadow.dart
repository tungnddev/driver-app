import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DriverShadow {
  static List<BoxShadow> normal({double borderRadius = 8.0}) => [BoxShadow(
    color: Colors.grey,
    blurRadius: borderRadius,
    offset: Offset(4, 2), // Shadow position
  ),];
}