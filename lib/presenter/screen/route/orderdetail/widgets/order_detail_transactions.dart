import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/order_detail_vm.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/widgets/divider.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailTransactions extends StatelessWidget {

  final OrderTransitionVM vm;

  const OrderDetailTransactions({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 10, top: 6, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextNormal(size: 13, fontWeight: FontWeight.bold, content: S.of(context).order_transactions,),
          SizedBox(height: 3,),
          TextNormal(size: 13, content: vm.time,),
          SizedBox(height: 3,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: TextNormal(size: 13, content: S.of(context).rental_fee,)),
              TextNormal(content: vm.fee, fontWeight: FontWeight.bold, size: 13,),
            ],
          ),
          SizedBox(height: 3,),
          TextNormal(content: vm.method, size: 13,)
        ],
      ),
    );
  }
}
