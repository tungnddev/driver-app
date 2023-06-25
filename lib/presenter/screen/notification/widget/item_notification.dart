import 'package:driver/presenter/models/notification_vm.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class ItemNotification extends StatelessWidget {
  final NotificationVM model;

  const ItemNotification({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 12,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 12,
            ),
            Image.asset(
              model.assetIcon,
              width: 32,
              height: 32,
            ),
            SizedBox(
              width: 17,
            ),
            Expanded(
                child: TextNormal(
              maxLine: 1,
              content: model.content,
            )),
            SizedBox(
              width: 12,
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          height: 1,
          color: ColorUtils.colorDivider,
        ),
      ],
    );
  }
}
