import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/route_date_vm.dart';
import 'package:driver/presenter/screen/route/route/mapviewbloc/map_view_state.dart';
import 'package:driver/routes/routes.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/divider.dart';
import 'package:driver/utils/widgets/gesture_detector.dart';
import 'package:driver/utils/widgets/loading_view.dart';
import 'package:driver/utils/widgets/small_button.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRouteWidget extends StatefulWidget {
  final DateTime dateTime;
  final Function()? onNext;
  final Function()? onPrevious;
  final MapViewState state;

  const DateRouteWidget({
    Key? key,
    required this.state,
    required this.dateTime,
    this.onNext,
    this.onPrevious,
  }) : super(key: key);

  @override
  _DataRouteWidgetState createState() => _DataRouteWidgetState();
}

class _DataRouteWidgetState extends State<DateRouteWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
            ),
            _buildButtonArrow(ImageUtils.icArrowPreviousDate, widget.onPrevious),
            SizedBox(
              width: 5,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextNormal(
                  align: TextAlign.center,
                  size: 16,
                  color: ColorUtils.greenHome,
                  content: DateFormat("MMMM dd, yyyy - EEEE")
                      .format(widget.dateTime),
                  fontWeight: TextNormal.BOLD,
                ),
                SizedBox(
                  height: 4,
                ),
                TextNormal(
                  size: 14,
                  content: widget.state is MapViewLoadSuccessful
                      ? (widget.state as MapViewLoadSuccessful).vm.subTitle
                      : "",
                )
              ],
            )),
            SizedBox(
              width: 5,
            ),
            _buildButtonArrow(ImageUtils.icArrowNextDate, widget.onNext),
            SizedBox(
              width: 20,
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        DividerApp(),
        SizedBox(
          height: 15,
        ),
        Expanded(child: _buildMainWidget()),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: DriverSmallButton(
              text: S.of(context).view_packing_slip,
              backgroundColor: ColorUtils.yellowSelectedTab,
              onTap: () {
                Navigator.pushNamed(context, Routes.packingSlip);
              },
              padding: EdgeInsets.symmetric(vertical: 12),
            )),
        SizedBox(
          height: 20,
        ),
        DividerApp(),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: DriverButton(
              textColor: Colors.black,
              backgroundColor: ColorUtils.grayBackButton,
              text: S.of(context).profile_back,
              onTap: () {},
            ))
      ],
    );
  }

  Widget _buildButtonArrow(String asset, Function()? onTap) => RippleInkWell(
    onTap: () => onTap?.call(),
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Image.asset(
          asset,
          width: 13,
          height: 20,
        ),
      ));

  Widget _buildMainWidget() {
    if (widget.state is MapViewLoadSuccessful) {
      RouteDateVM vm = (widget.state as MapViewLoadSuccessful).vm;
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextNormal(
              size: 14,
              content:
                  "${S.of(context).earliest_time}: ${vm.timePickUp}",
            ),
            SizedBox(
              height: 10,
            ),
            TextNormal(
              size: 14,
              content:
                  "${S.of(context).est_total_miles}: ${vm.estTotalMiles}",
            ),
            SizedBox(
              height: 3,
            ),
            TextNormal(
              size: 14,
              content:
                  "${S.of(context).est_total_pay}: ${vm.estTotalPay}",
            ),
          ],
        ),
      );
    } else {
      return LoadingView();
    }
  }
}
