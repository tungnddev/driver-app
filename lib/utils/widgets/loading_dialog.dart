import 'package:driver/routes/routes.dart';
import 'package:driver/utils/widgets/loading_view.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class LoadingDialog {
  static void show(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Color(0x88000000),
        pageBuilder: (_, __, ___) => LoadingView());
  }
}
