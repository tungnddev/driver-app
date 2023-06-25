import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/order_detail_vm.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/widgets/expandable_view.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class OrderDetailPrice extends StatelessWidget {
  final List<OrderLineFeeVM> fee;

  const OrderDetailPrice({Key? key, required this.fee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 6, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: fee
            .mapIndexed((index, element) =>
                _buildItemLine(element, isLastLine: index == fee.length - 1))
            .toList(),
      ),
    );
  }

  Widget _buildItemLine(OrderLineFeeVM model, {isLastLine = false}) => Padding(
        padding: EdgeInsets.symmetric(vertical: 1.5),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          TextNormal(
            content: "${model.title}:",
            size: 12,
            fontWeight: isLastLine ? FontWeight.bold : FontWeight.normal,
          ),
          SizedBox(
            width: 3,
          ),
          Expanded(
              child: Text(
            "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ",
            style: TextStyle(
              color: ColorUtils.colorGrayUnderLine,
            ),
            maxLines: 1,
          ),),
          SizedBox(
            width: 3,
          ),
          SizedBox(
            width: 55,
            child: TextNormal(
              content: model.fee,
              maxLine: 1,
              fontWeight: FontWeight.bold,
              size: 12,
              align: TextAlign.end,
              color: isLastLine ? ColorUtils.colorRedPrice : Colors.black,
            ),
          )
        ]),
      );
}
