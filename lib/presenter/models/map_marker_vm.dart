import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:driver/presenter/screen/route/route/widgets/paint_draw_marker.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarkerVM {
  LatLng latLng;
  int index;
  int id;
  String place;
  Color color;
  Uint8List? image;

  MapMarkerVM(this.latLng, this.index, this.id, this.place, this.color);

  // Widget get widget {
  //   return RepaintBoundary(
  //     key: iconKey,
  //     child: Container(
  //       padding: EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 10),
  //       decoration: BoxDecoration(
  //           image: DecorationImage(
  //               image: AssetImage(ImageUtils.icMarkerMap), fit: BoxFit.fill)),
  //       child: TextNormal(
  //         content: "${index + 1}",
  //         size: 18,
  //       ),
  //     ),
  //   );
  // }

  // Future<Uint8List> getUint8List() async {
  //   RenderRepaintBoundary boundary =
  //       iconKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //   var image = await boundary.toImage(pixelRatio: 2.0);
  //   ByteData byteData =
  //       (await image.toByteData(format: ui.ImageByteFormat.png))!;
  //   return byteData.buffer.asUint8List();
  // }

  Widget get widget {
    double widthIcon = 30;
    if (index > 10) {
      widthIcon = 40;
    } else if (index > 100) {
      widthIcon = 50;
    }
    return Container(
      width: widthIcon,
      height: 34,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: widthIcon,
            height: 34,
            decoration:
                ShapeDecoration(color: Colors.black, shape: MessageBorder()),
          ),
          Container(
            width: widthIcon - 2,
            height: 32,
            decoration: ShapeDecoration(
              color: color,
              shape: MessageBorder(),
            ),
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: TextNormal(
                  content: "${index + 1}",
                  maxLine: 1,
                  size: 18,
                )),
          )
        ],
      ),
    );
  }
}
