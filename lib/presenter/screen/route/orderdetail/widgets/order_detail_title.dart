import 'package:driver/presenter/models/order_detail_vm.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class OrderDetailTitle extends StatelessWidget {
  final OrderDetailVM vm;
  const OrderDetailTitle({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 27, top: 16, bottom: 16),
      alignment: Alignment.centerRight,
      child: TextNormal(size: 16, content: vm.title, fontWeight: TextNormal.BOLD,),
      color: vm.bgColor,
    );
  }
}
