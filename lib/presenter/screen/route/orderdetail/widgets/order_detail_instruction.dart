import 'package:driver/generated/l10n.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/widgets/divider.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailSpecialInstruction extends StatelessWidget {

 final  String instructions;

  const OrderDetailSpecialInstruction({Key? key, required this.instructions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 7,),
        Padding(padding: EdgeInsets.only(left: 25, right: 6, bottom: 3), child: TextNormal(content: S.of(context).special_instructions, size: 13, fontWeight: FontWeight.bold,),),
        SizedBox(height: 3,),
        Padding(padding: EdgeInsets.only(left: 25, right: 6, bottom: 10), child: TextNormal(content: instructions, size: 13,),),
        DividerApp(color: ColorUtils.grayUnSelectedTab,)
      ],
    );
  }
}
