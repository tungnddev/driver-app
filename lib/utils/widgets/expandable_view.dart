import 'package:flutter/material.dart';

import 'gesture_detector.dart';

typedef WidgetTitle = Widget Function(bool isExpand);

class ExpandableView extends StatefulWidget {
  final WidgetTitle childTitle;
  final Widget childExpand;
  final Widget? childBottom;
  final bool initExpand;

  ExpandableView(
      {required this.childTitle, required this.childExpand, this.childBottom, this.initExpand = false});

  @override
  _ExpandableViewState createState() => _ExpandableViewState();
}

class _ExpandableViewState extends State<ExpandableView>
    with SingleTickerProviderStateMixin {
  late bool isExpanding;
  late AnimationController expandController;
  late Animation<double> animation;

  _ExpandableViewState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    isExpanding = widget.initExpand;
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  void _runExpandCheck() {
    if (isExpanding) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RippleInkWell(
            onTap: () {
              isExpanding = !isExpanding;
              _runExpandCheck();
              setState(() {});
            },
            child: widget.childTitle(isExpanding)
          ),
          SizeTransition(
              axisAlignment: 1.0, sizeFactor: animation, child: widget.childExpand),
          ...widget.childBottom != null ? [widget.childBottom!] : []
        ],
      ),
    );
  }
}