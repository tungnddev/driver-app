import 'dart:ui';

import 'package:driver/presenter/models/packing_slip_vn.dart';
import 'package:driver/presenter/screen/route/packingslip/packing_slip_type.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class PackingSlipTitle extends StatelessWidget {

  final String dateTime;
  final PackingSlipType type;

  const PackingSlipTitle({Key? key, required this.dateTime, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: type.colorTitle,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(
        children: [
          Expanded(child: TextNormal(
            content: type.title(context),
            fontWeight: FontWeight.bold,
            size: 16,
          )),
          TextNormal(
            content: dateTime,
            size: 13,
          )
        ],
      ),
    );
  }
}
