import 'dart:ui';

import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/packing_slip_vn.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class PackingSlipItem extends StatefulWidget {

  final PackingSlipItemVM model;
  final int index;

  const PackingSlipItem({Key? key, required this.model, required this.index}) : super(key: key);

  @override
  _PackingSlipItemState createState() => _PackingSlipItemState();
}

class _PackingSlipItemState extends State<PackingSlipItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.model.isSelecting = !widget.model.isSelecting;
        setState(() {
        });
      },
      child: Container(
        color: widget.index % 2 == 0 ? ColorUtils.grayUnSelectedTab : Colors.white,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            _buildSimpleColumn(widget.model.invoice, 3),
            _buildOrderItems(8),
            _buildSimpleColumn(widget.model.quantity, 4)
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleColumn(String text, int flex) {
    return Expanded(child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: TextNormal(
        content: text,
        size: 13,
        align: TextAlign.center,
        maxLine: 1,
      ),
    ), flex: flex,);
  }

  Widget _buildOrderItems(int flex) {
    return Expanded(child: Row(
      children: [
        Image.asset(
          widget.model.isSelecting
              ? ImageUtils.icCheck
              : ImageUtils.icUnCheck,
          width: 16,
          height: 16,
        ),
        SizedBox(width: 10,),
        TextNormal(
          content: widget.model.orderItem,
          size: 13,
        ),
      ],
    ), flex: flex,);
  }
}
