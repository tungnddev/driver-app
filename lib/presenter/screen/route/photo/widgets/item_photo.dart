import 'dart:io';

import 'package:driver/presenter/models/image_vm.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/images.dart';
import 'package:driver/utils/widgets/loading_view.dart';
import 'package:flutter/material.dart';

class ItemPhoto extends StatelessWidget {
  final ImageVM imageVM;
  final int index;
  final Function()? onTap;

  const ItemPhoto({Key? key, required this.imageVM, required this.index, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: PhysicalModel(
        color: Colors.black,
        elevation: 2,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ColorUtils.colorBorderNote, width: 0.3)
                ),
                alignment: Alignment.center,
                child: _buildMainImage(imageVM, index)),
            Positioned.fill(
              child: Visibility(
                visible: imageVM.status == ImageStatus.loading,
                child: Container(
                    color: const Color(0x5EFFFFFF),
                    child: LoadingView(
                      size: 20,
                      strokeWidth: 1.5,
                    )),
              ),
            ),
            Positioned.fill(
              child: Visibility(
                visible: imageVM.status == ImageStatus.fail,
                child: Container(
                    color: const Color(0x5EFFFFFF),
                    child: Icon(
                      Icons.error,
                      size: 20,
                    )),
              ),
            ),
            // Visibility(
            //     visible: image.status != ImageSectionStatus.LOADING &&
            //         isNotEmpty(image.path),
            //     child: GestureDetector(
            //       onTap: () {
            //         bloc.add(ImageSectionDelete(index: index));
            //       },
            //       child: Padding(
            //         padding: EdgeInsets.all(7),
            //         child: Image.asset(
            //           ImageUtils.icDeleteImageSection,
            //           width: 24,
            //           height: 24,
            //         ),
            //       ),
            //     ))
          ],
        ),
      ),
    );
  }

  Widget _buildMainImage(ImageVM vm, int index) {
    if (vm.path.isEmpty) {
      if (index == 0) {
        return Image.asset(
          ImageUtils.icAddPhotoFirst,
          width: 74,
          height: 74,
        );
      } else {
        return Image.asset(
          ImageUtils.icAddPhoto,
          width: 40,
          height: 40,
        );
      }
    }
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.file(
        File(imageVM.path),
        fit: BoxFit.cover,
      ),
    );
  }
}
