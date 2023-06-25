import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/widgets/gesture_detector.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListDateHorizontal extends StatefulWidget {

  final Function(DateTime date)? onChange;
  final Color colorSelected;

  const ListDateHorizontal({Key? key, this.onChange, required this.colorSelected}) : super(key: key);

  @override
  _ListDateHorizontalState createState() => _ListDateHorizontalState();
}

class _ListDateHorizontalState extends State<ListDateHorizontal> {
  int numDays = 31;
  double widthItem = 160;
  final _controller = ScrollController();
  int currentSelected = 0;

  @override
  void initState() {
    super.initState();
    currentSelected = numDays ~/ 2;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _controller.animateTo(widthItem * (numDays ~/ 2) + widthItem / 2 - MediaQuery.of(context).size.width / 2, duration: Duration(milliseconds: 1), curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(height: 42, child: ListView.builder(itemBuilder: (context, index) => _buildItemDay(index), itemCount: numDays, controller: _controller, scrollDirection: Axis.horizontal,));
  }

  _buildItemDay(int index) {
    int middleIndex = numDays ~/ 2;
    DateTime dateTime = index > middleIndex ? DateTime.now().add(Duration(days: index - middleIndex)) : DateTime.now().subtract(Duration(days: middleIndex - index));
    return RippleInkWell(
      onTap: () {
        widget.onChange?.call(dateTime);
        setState(() {
          currentSelected = index;
        });
      },
      child: Container(
        color: currentSelected == index ? Colors.white : ColorUtils.grayUnSelectedTab,
        height: 42,
        width: widthItem,
        alignment: Alignment.center,
        child: TextNormal(
          color: currentSelected == index ? widget.colorSelected : Colors.white,
          content: DateFormat("MMMM dd, yyyy").format(dateTime),
          fontWeight: currentSelected == index ? TextNormal.SEMI_BOLD : TextNormal.REGULAR,
          size: 13.5,
        ),
      ),
    );
  }
}
