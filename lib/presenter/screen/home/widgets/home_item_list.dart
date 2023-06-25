import 'package:driver/generated/l10n.dart';
import 'package:driver/routes/routes.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/gesture_detector.dart';
import 'package:driver/utils/widgets/shadow.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeItemList extends StatelessWidget {
  const HomeItemList({Key? key}) : super(key: key);

  final double paddingHorizontal = 51;
  final double paddingHorizontalBetween = 26;
  final double paddingItem = 25;

  @override
  Widget build(BuildContext context) {
    double sizeItem = (MediaQuery
        .of(context)
        .size
        .width -
        2 * paddingHorizontal -
        paddingHorizontalBetween) /
        2.0;
    double sizeIcon = sizeItem - 2 * paddingItem;
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      color: ColorUtils.bgHomeItemList,
      padding: EdgeInsets.symmetric(vertical: 25),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildItemHome(ImageUtils.icHomeCalendar, S
                  .of(context)
                  .home_calendar,
                  ColorUtils.orangeHome, sizeItem, sizeIcon, onTap: () {
                    Navigator.pushNamed(context, Routes.calendar);
                  }),
              SizedBox(
                width: paddingHorizontalBetween,
              ),
              _buildItemHome(ImageUtils.icHomeRoute, S
                  .of(context)
                  .home_route,
                  ColorUtils.greenHome, sizeItem, sizeIcon, onTap: () => Navigator.pushNamed(context, Routes.route)),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildItemHome(ImageUtils.icHomeProfile, S
                  .of(context)
                  .home_profile,
                  ColorUtils.blueHome, sizeItem, sizeIcon, onTap: () {
                Navigator.pushNamed(context, Routes.profile);
                  }),
              SizedBox(
                width: paddingHorizontalBetween,
              ),
              _buildItemHome(ImageUtils.icHomeNotification, S
                  .of(context)
                  .home_notification,
                  ColorUtils.redHome, sizeItem, sizeIcon, badge: 5, onTap: () {
                    Navigator.pushNamed(context, Routes.notification);
                  }),
            ],
          ),
        ],
      ),
    );
  }

  _buildItemHome(String asset, String text, Color textColor, double sizeItem,
      double sizeIcon, {int badge = 0, Function()? onTap}) =>
      Stack(
        children: [
          RippleInkWell(
            onTap: () {
              onTap?.call();
            },
            child: Padding(
              padding: EdgeInsets.all(5),
              child: PhysicalModel(
                color: Colors.black,
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: sizeItem,
                  height: sizeItem,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        asset,
                        width: sizeIcon,
                        height: sizeIcon,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextNormal(
                        fontWeight: TextNormal.MEDIUM,
                        content: text,
                        maxLine: 1,
                        color: textColor,
                        size: 14,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: badge > 0,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2, color: Colors.white),
                  shape: BoxShape.circle,
                  color: ColorUtils.colorNotification),
              alignment: Alignment.center,
              child: TextNormal(
                size: 13,
                content: badge.toString(),
                color: Colors.white,
              ),
            ),
          )
        ],
      );
}
