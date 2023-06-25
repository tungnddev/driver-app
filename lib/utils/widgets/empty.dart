import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class NewEmptyViewRefresh extends StatelessWidget {
  final String content;
  final Future<void> Function() onRefresh;

  NewEmptyViewRefresh(
      {required this.content, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                TextNormal(
                  content: this.content,
                  align: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        onRefresh: () => onRefresh());
  }
}