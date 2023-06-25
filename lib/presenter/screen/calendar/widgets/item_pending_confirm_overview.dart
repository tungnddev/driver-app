import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/pending_confirm_overview_vm.dart';
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

class ItemPendingConfirmOverview extends StatelessWidget {
  final PendingConfirmOverviewVM model;
  final int index;
  final Function()? onDecline;
  final Function()? onAccept;

  const ItemPendingConfirmOverview(
      {Key? key,
      required this.model,
      required this.index,
      this.onAccept,
      this.onDecline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableView(
        childTitle: (isExpanding) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                content: model.content,
                size: 13,
              ),
              SizedBox(
                height: 4,
              ),
              TextNormal(
                content: "${S.of(context).estimate_miles}: ${model.distance}",
                size: 13,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: TextNormal(
                        content: "${S.of(context).estimated_pay}: ${model.pay}",
                        size: 13,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                      width: 70,
                      child: DriverSmallButton(
                        text: S.of(context).decline_button,
                        backgroundColor: ColorUtils.redDeclineButton,
                        onTap: onDecline,
                      )),
                  SizedBox(
                    width: 14,
                  ),
                  SizedBox(
                      width: 70,
                      child: DriverSmallButton(
                        text: S.of(context).accept_button,
                        backgroundColor: ColorUtils.colorApplyButton,
                        onTap: onAccept,
                      )),
                ],
              )
            ],
          ),
        ),  childBottom: DividerApp(),);
  }
}
