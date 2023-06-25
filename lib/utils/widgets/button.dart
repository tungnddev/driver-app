import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DriverButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Function()? onTap;

  const DriverButton(
      {Key? key,
      required this.text,
      this.textColor = Colors.white,
      this.backgroundColor = ColorUtils.colorBlueButton,
      this.onTap,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, child: PhysicalModel(
        color: Colors.black,
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: CupertinoButton(
          onPressed: onTap,
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: textColor, fontSize: 14, fontWeight: TextNormal.SEMI_BOLD),
          ),
          color: backgroundColor,
          padding: EdgeInsets.only(top: 0, bottom: 0),
          minSize: 40,
          borderRadius: BorderRadius.circular(12),
          pressedOpacity: 0.8,
        ),
      ),
    );
  }
}
