import 'package:driver/utils/define/colors.dart';
import 'package:flutter/material.dart';

class InputConstraint extends StatelessWidget {
  final Function(String text) onChange;
  final int maxLength;
  final double height;
  final Color colorBorder;
  final String hint;

  InputConstraint(
      {required this.onChange,
      this.maxLength = 255,
      this.height = 100,
      this.colorBorder = ColorUtils.borderTabCalendar,
      this.hint = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: colorBorder)),
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
      child: TextField(
        maxLength: maxLength,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: TextStyle(fontSize: 16, ),
        decoration: InputDecoration(
            counter: SizedBox(
              width: 0,
              height: 0,
            ),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.only(left: 0, right: 0, top: 0),
        hintText: hint,
        hintStyle: TextStyle(color: Color.fromRGBO(106, 106, 106, 0.5), fontSize: 16)),
        onChanged: onChange,
      ),
    );
  }
}
