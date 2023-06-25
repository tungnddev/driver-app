import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/pending_confirm_vm.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/divider.dart';
import 'package:driver/utils/widgets/small_button.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemPendingConfirm extends StatelessWidget {
  final PendingConfirmVM model;
  final int index;
  final Function()? onDecline;
  final Function()? onAccept;

  const ItemPendingConfirm(
      {Key? key,
      required this.model,
      required this.index,
      this.onAccept,
      this.onDecline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 14, top: 16, bottom: 13),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: 35,
                child: TextNormal(
                  content: "${index + 1}",
                  size: 14,
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextNormal(
                    content: model.place,
                    size: 15,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextNormal(
                    content: model.content,
                    size: 13,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextNormal(
                    content: "${S.of(context).est_pay}: ${model.estPay}",
                    size: 13,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: TextNormal(
                            content:
                                "${S.of(context).est_distance}: ${model.estDistance}",
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
              ))
            ],
          ),
        ),
        DividerApp()
      ],
    );
  }
}
