import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DriverButtonWithArrow extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Function()? onTap;

  const DriverButtonWithArrow(
      {Key? key,
        required this.text,
        this.textColor = Colors.black,
        this.backgroundColor = ColorUtils.yellowSelectedTab,
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
        child: Row (
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: textColor, fontSize: 13),
              ),
            ),
            SizedBox(height: 3,),
            Image.asset(ImageUtils.icArrowRight, width: 20, height: 25,)
          ],
        ),
        color: backgroundColor,
        padding: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
        minSize: 40,
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    );
  }
}
