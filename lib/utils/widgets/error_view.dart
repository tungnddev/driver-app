import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final double size;
  const ErrorView({Key? key, this.size = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Icon(Icons.error, color: Colors.red, size: size,));
  }
}
