import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class DriverAppBar extends StatelessWidget {
  final String asset;
  final String title;
  final Color color;
  final double sizeIcon;
  const DriverAppBar({Key? key, required this.asset, required this.title, required this.color, this.sizeIcon = 25}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 4, color: Colors.white),
                shape: BoxShape.circle,
                color: color),
            child: Image.asset(asset, width: sizeIcon, height: sizeIcon,),
          ),
          SizedBox(width: 15,),
          Expanded(child: Padding(padding: EdgeInsets.only(top: 10),
              child: TextSemiBoldNormal(content: title, size: 24, maxLine: 1, color: Colors.white,))),
          SizedBox(width: 15,),
          Image.asset(ImageUtils.icAppBarMore, width: 28.8, height: 20.8,)
        ],
      ),
    );
  }
}
