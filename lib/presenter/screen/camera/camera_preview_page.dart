import 'dart:io';

import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/image_vm.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:flutter/material.dart';

class CameraPreviewPage extends StatelessWidget {
  final String path;

  const CameraPreviewPage({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(child: Stack(
              alignment: Alignment.topRight,
              children: [
                Image.file(File(path), width: double.infinity, height: double.infinity, fit: BoxFit.cover,),
                GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 10, right: 20, left: 15),
                      child: Image.asset(ImageUtils.imgCloseCamera, width: 19, height: 19,),
                    ),
                    onTap: () => Navigator.pop(context))

              ],
            )),
            Container(
                height: 90,
              color: Colors.black,
              alignment: Alignment.center,
              child: _buildButton(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16,),
        Expanded(
          child: DriverButton(
            textColor: Colors.black,
            backgroundColor: Color(0xFFD3D3D3),
            text: S.of(context).discard,
            onTap: () {
              Navigator.pop(context, false);
            },
          ),
          flex: 1,
        ),
        SizedBox(
          width: 18,
        ),
        Expanded(
          child: DriverButton(
            backgroundColor: ColorUtils.greenHome,
            text: S.of(context).save,
            onTap: () {
              Navigator.pop(context, true);
            },
          ),
          flex: 2,
        ),
        SizedBox(width: 16,),
      ],
    );
  }
}
