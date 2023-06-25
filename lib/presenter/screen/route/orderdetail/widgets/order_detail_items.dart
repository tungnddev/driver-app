import 'dart:ui';

import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/order_detail_vm.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/widgets/divider.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailItems extends StatelessWidget {
  final OrderDetailVM vm;

  const OrderDetailItems({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, 
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 13,
            horizontal: 25,
          ),
          child: TextNormal(
            color: ColorUtils.greenHome,
            content: S.of(context).order_items,
            size: 12,
            fontWeight: TextNormal.BOLD,
          ),
        ),
        _buildItemHeader(context),
        ...vm.orderItems.map((e) => _buildItemOrder(context, e))
      ],
    );
  }

  _buildItemHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25, top: 5, bottom: 5),
      color: ColorUtils.greenHome,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextNormal(
              color: Colors.white,
              content: S.of(context).description,
              size: 12,
              fontWeight: FontWeight.bold,
              maxLine: 1,
            ),
            flex: 58,
          ),
          Expanded(
            child: TextNormal(
              color: Colors.white,
              content: S.of(context).QTY,
              size: 11,
              maxLine: 2,
              align: TextAlign.center,
            ),
            flex: 7,
          ),
          Expanded(
            child: TextNormal(
              color: Colors.white,
              content: S.of(context).unit_price.toUpperCase(),
              size: 11,
              maxLine: 2,
              align: TextAlign.center,
            ),
            flex: 17,
          ),
          Expanded(
            child: TextNormal(
              color: Colors.white,
              content: S.of(context).total.toUpperCase(),
              size: 11,
              maxLine: 2,
              align: TextAlign.center,
            ),
            flex: 17,
          ),
        ],
      ),
    );
  }

  Widget _buildItemOrder(BuildContext context, OrderDetailItemVM model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 25, top: 12, bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextNormal(
                      content: model.title,
                      size: 13,
                    ),
                    SizedBox(height: 3,),
                    TextNormal(content: model.description, size: 11,)
                  ],
                ),
                flex: 58,
              ),
              Expanded(
                child: TextNormal(
                  content: model.quantity,
                  size: 12,
                  maxLine: 2,
                  align: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
                flex: 7,
              ),
              Expanded(
                child: TextNormal(
                  content: model.unitPrice,
                  size: 12,
                  maxLine: 2,
                  align: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
                flex: 17,
              ),
              Expanded(
                child: TextNormal(
                  content: model.total,
                  size: 12,
                  maxLine: 2,
                  align: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
                flex: 17,
              ),
            ],
          ),
        ),
        DividerApp(color: ColorUtils.grayUnSelectedTab,)
      ],
    );
  }
}
