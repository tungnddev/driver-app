import 'package:driver/app/app.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/routes/routes.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/app_bar.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/scaffold_with_color.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class DriverPaymentPage extends StatelessWidget {
  const DriverPaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DriverPaymentWidget();
  }
}

class DriverPaymentWidget extends StatefulWidget {
  const DriverPaymentWidget({Key? key}) : super(key: key);

  @override
  _DriverPaymentWidgetState createState() => _DriverPaymentWidgetState();
}

class _DriverPaymentWidgetState extends State<DriverPaymentWidget> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithColor(color: ColorUtils.grayPackingSlip, child: Column(
      children: [
        Expanded(child: Column(
          children: [
            DriverAppBar(asset: ImageUtils.icAppBarDriverPayment, title: S.of(context).driver_payment, color: ColorUtils.grayPackingSlip),
            SizedBox(height: 77,),
            TextNormal(content: S.of(context).cha_ching, color: ColorUtils.colorNote, size: 16,),
            SizedBox(height: 20,),
            TextNormal(content: S.of(context).you_earned, color: ColorUtils.colorNote, size: 24,),
            SizedBox(height: 4,),
            TextNormal(content: "\$85", color: ColorUtils.colorNote, size: 65,),
            SizedBox(height: 4,),
            TextNormal(content: S.of(context).on_this_trip, color: ColorUtils.colorNote, size: 24,),
            SizedBox(height: 4,),
          ],
        )),
        _buildButton()
      ],
    ));
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: DriverButton(
              textColor: Colors.black,
              backgroundColor: Color(0xFFD3D3D3),
              text: S.of(context).profile_back,
              onTap: () {},
            ),
            flex: 1,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: DriverButton(
              text: S.of(context).view_next_order,
              onTap: () {
              },
              backgroundColor: ColorUtils.yellowSelectedTab,
              textColor: Colors.black,
            ),
            flex: 2,
          )
        ],
      ),
    );
  }
}

