import 'dart:async';
import 'dart:typed_data';

import 'package:driver/presenter/models/map_marker_vm.dart';
import 'package:driver/presenter/screen/route/route/widgets/marker_generate.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteMapMarkerStream {
  StreamController<List<Uint8List>> _streamController = StreamController.broadcast();

  get stream => _streamController.stream;

  void close() {
    _streamController.close();
  }

  // void addValue(List<MapMarkerVM> listMarker) async {
  //   // await Future.delayed(Duration(seconds: 10));
  //   var futures = listMarker.map((e) => e.getUint8List());
  //   _streamController.add(await Future.wait(futures));
  // }

  void addRawValue(List<MapMarkerVM> listMarker, BuildContext context) async {
    if (listMarker.isNotEmpty) {
      MarkerGenerator(listMarker.map((e) => e.widget).toList(),
              (List<Uint8List> list) {
            _streamController.add(list);
          }).generate(context);
    } else {
      _streamController.add([]);
    }

    // await Future.delayed(Duration(milliseconds: 50), () {
    //   MarkerGenerator(listMarker.map((e) => e.widget).toList(),
    //           (List<Uint8List> list) {
    //         _streamController.add(list);
    //       }).generate(context);
    // });
  }
}