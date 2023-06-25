import 'package:driver/generated/l10n.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class PackingSlipHeader extends StatelessWidget {
  final String text1, text2, text3;

  const PackingSlipHeader(
      {Key? key, required this.text1, required this.text2, required this.text3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorUtils.colorHeaderPackingSlip,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          _buildTextExpanded(text1, 3, TextAlign.center),
          _buildTextExpanded(text2, 8, TextAlign.left),
          _buildTextExpanded(text3, 4, TextAlign.center)
        ],
      ),
    );
  }

  Widget _buildTextExpanded(String text, int flex, TextAlign align) {
    return Expanded(child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: TextNormal(
        content: text,
        color: Colors.white,
        size: 13,
        align: align,
        maxLine: 1,
      ),
    ), flex: flex,);
  }
}
