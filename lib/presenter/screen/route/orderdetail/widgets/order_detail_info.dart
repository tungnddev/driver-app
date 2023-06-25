import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/order_detail_vm.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/widgets/divider.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class OrderDetailInfo extends StatelessWidget {
  final OrderDetailVM vm;
  const OrderDetailInfo({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCustomerInfo(context),
        DividerApp(color: ColorUtils.grayUnSelectedTab,),
        _buildLocation(context),
        DividerApp(color: ColorUtils.grayUnSelectedTab,),
        _buildDateTime(context),
        DividerApp(color: ColorUtils.grayUnSelectedTab,)
      ],
    );
  }

  Widget _buildCustomerInfo(BuildContext context) => Padding(
    padding: EdgeInsets.only(left: 25, top: 12, bottom: 12, right: 13),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: TextNormal(content: S.of(context).customer_information, size: 13,)),
            _buildStatusTag(),
          ],
        ),
        TextNormal(content: vm.customerName, size: 13,),
        SizedBox(height: 3,),
        TextNormal(content: vm.customerPhone, size: 13,)
      ],
    ),
  );

  Widget _buildLocation(BuildContext context) => Padding(
    padding: EdgeInsets.only(left: 25, top: 10, bottom: 13, right: 13),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextNormal(content: S.of(context).event_location, size: 13,),
        SizedBox(height: 3,),
        TextNormal(content: vm.location, size: 13,)
      ],
    ),
  );

  Widget _buildDateTime(BuildContext context) => Padding(
    padding: EdgeInsets.only(left: 25, top: 13, bottom: 20, right: 13),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextNormal(content: S.of(context).rental_date_time, size: 13,),
        SizedBox(height: 3,),
        TextNormal(content: "${vm.rentalDateFrom} ${S.of(context).to}", size: 13,),
        SizedBox(height: 3,),
        TextNormal(content: vm.rentalDateTo, size: 13,),
        SizedBox(height: 15,),
        TextNormal(content: "${S.of(context).estimate_drop_off} ${vm.estDropOff}", size: 13,),
        SizedBox(height: 3,),
        TextNormal(content: "${S.of(context).estimate_pick_up} ${vm.estPickUp}", size: 13,)
      ],
    ),
  );

  Widget _buildStatusTag() => Container(
      width: 80,
      height: 25,
      alignment: Alignment.center,
      child: TextNormal(
        size: 12.5,
        color: vm.colorTextStatus,
        content: vm.status,
        maxLine: 1,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: vm.colorStatus));
}
