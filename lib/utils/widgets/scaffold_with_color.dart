import 'package:flutter/material.dart';

class ScaffoldWithColor extends StatelessWidget {

  final Widget child;
  final Color color;

  const ScaffoldWithColor({Key? key, required this.color, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: color,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: child,
          ),
        ),
      ),
    );
  }
}
