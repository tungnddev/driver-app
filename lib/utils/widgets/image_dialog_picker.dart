import 'dart:io';

import 'package:driver/generated/l10n.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import 'divider.dart';
import 'gesture_detector.dart';

class ImageDialogPicker {
  static showDialogSelectImage(
      Function(String path) actionWithPhoto, BuildContext context) async {
    final picker = ImagePicker();
    FocusScope.of(context).unfocus();

    Widget itemCamera(String content, String image, Function() onClick) {
      return RippleInkWell(
        onTap: onClick,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    image,
                    width: 18,
                    height: 18,
                    fit: BoxFit.contain,
                    color: ColorUtils.colorText,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: TextNormal(
                        content: content, color: ColorUtils.colorText),
                  ),
                ],
              ),
            ),
            DividerApp(),
          ],
        ),
      );
    }

    CompressFormat? _getCompressType(String path) {
      if (path.endsWith(".heic")) {
        return CompressFormat.heic;
      } else if (path.endsWith(".webp")) {
        return CompressFormat.webp;
      } else if (path.endsWith(".png")) {
        return CompressFormat.png;
      } else if (path.endsWith(".jpg") || path.endsWith(".jpeg")) {
        return CompressFormat.jpeg;
      }
      return null;
    }

    compressImage(String path) async {
      int lastPointIndex = path.lastIndexOf(".");
      if (lastPointIndex == -1) return;
      String pathCompress = path.substring(0, lastPointIndex) +
          "_com" +
          path.substring(lastPointIndex);
      CompressFormat? compressFormat = _getCompressType(path.toLowerCase());
      if (compressFormat == null) return;
      await FlutterImageCompress.compressAndGetFile(path, pathCompress,
          format: compressFormat, quality: 60);
      File fileOrigin = new File(path);
      File fileCompress = new File(pathCompress);
      await fileOrigin.delete();
      await fileCompress.rename(path);
    }

    takePhotoFromCamera() async {
      Navigator.pop(context);
      PickedFile? pickedFile =
          await picker.getImage(source: ImageSource.camera);
      if (pickedFile != null) {
        await compressImage(pickedFile.path);
        actionWithPhoto(pickedFile.path);
      }
    }

    selectPhotoFromGallery() async {
      Navigator.pop(context);
      PickedFile? pickedFile =
          await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        await compressImage(pickedFile.path);
        actionWithPhoto(pickedFile.path);
      }
    }

    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
            height: 120,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  itemCamera(S.of(context).take_a_photo, ImageUtils.icCamera,
                      takePhotoFromCamera),
                  itemCamera(S.of(context).select_from_gallery,
                      ImageUtils.imgAddImage, selectPhotoFromGallery),
                ],
              ),
            )));
  }
}
