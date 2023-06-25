import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/activate_route_vm.dart';
import 'package:driver/presenter/models/pending_confirm_vm.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/divider.dart';
import 'package:driver/utils/widgets/expandable_view.dart';
import 'package:driver/utils/widgets/small_button.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemActivateRoute extends StatelessWidget {
  final ActivateRouteVM model;
  final int index;
  final Function()? onDetail;

  const ItemActivateRoute(
      {Key? key, required this.model, required this.index, this.onDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableView(
      childTitle: (isExpanding) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: TextNormal(
              content: model.title,
            )),
            SizedBox(
              width: 15,
            ),
            RotatedBox(
              quarterTurns: isExpanding ? 0 : 2,
              child: Image.asset(
                ImageUtils.icCalendarArrowUp,
                width: 21,
                height: 13,
              ),
            )
          ],
        ),
      ),
      childExpand: Padding(
        padding: const EdgeInsets.only(left: 30, right: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextNormal(
              content: "${S.of(context).estimate_miles}: ${model.distance}",
              size: 15,
            ),
            SizedBox(
              height: 4,
            ),
            TextNormal(
              content: "${S.of(context).estimated_pay}: ${model.pay}  ",
              size: 13,
            ),
            SizedBox(
              height: 4,
            ),
            TextNormal(
              content: "${S.of(context).gratuity}: ${model.gratuity}",
              size: 13,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: DriverSmallButton(
                text: S.of(context).view_order_detail,
                backgroundColor: ColorUtils.orangeHome,
                onTap: onDetail,
                textColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
      childBottom: DividerApp(),
    );
  }
}
