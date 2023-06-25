import 'package:driver/generated/l10n.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/widgets/shadow.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class HomeWeather extends StatelessWidget {
  const HomeWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.black,
      borderRadius: BorderRadius.circular(8),
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            TextNormal(
              content: S.of(context).home_weather,
              color: ColorUtils.blueHome,
              size: 14,
              fontWeight: TextNormal.MEDIUM,
            ),
            SizedBox(height: 150,)
          ],
        ),
      ),
    );
  }
}
