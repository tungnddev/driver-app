import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DriverSmallButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Function()? onTap;
  final EdgeInsets padding;

  const DriverSmallButton(
      {Key? key,
      required this.text,
      this.textColor = Colors.black,
      this.backgroundColor = ColorUtils.colorBlueButton,
      this.onTap,
      this.padding = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: PhysicalModel(
        color: Colors.black,
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: CupertinoButton(
          onPressed: onTap,
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: textColor, fontSize: 13, fontWeight: TextNormal.REGULAR),
          ),
          color: backgroundColor,
          padding: padding,
          minSize: 28,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
