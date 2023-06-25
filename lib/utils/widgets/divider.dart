import 'package:driver/utils/define/colors.dart';
import 'package:flutter/material.dart';

class DividerApp extends StatelessWidget {
  final double height;
  final Color color;

  DividerApp({this.height = 1, this.color = ColorUtils.bgHomeItemList});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.color,
      height: height,
    );
  }
}