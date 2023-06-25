import 'package:driver/presenter/screen/calendar/widgets/list_date_horizontal.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class HeaderRoute extends StatelessWidget {

  final Color color;
  final String text;
  final Widget child;

  const HeaderRoute({Key? key, required this.color, required this.text, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 10),
          child: TextBoldNormal(
            color: Colors.white,
            content: text,
            size: 18.5,
          ),),
          child,
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
