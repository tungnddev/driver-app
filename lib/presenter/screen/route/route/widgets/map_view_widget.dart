import 'dart:async';
import 'dart:typed_data';

import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/map_marker_vm.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/gesture_detector.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import 'custom_window_infor.dart';
import 'package:collection/collection.dart';

class MapViewWidget extends StatefulWidget {
  final List<MapMarkerVM> listMarker;

  const MapViewWidget({Key? key, required this.listMarker}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapViewWidget> {
  Completer<GoogleMapController> _controller = Completer();
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  // RouteMapMarkerStream _markerStream = RouteMapMarkerStream();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(34.064634, -118.233123),
    zoom: 14.4746,
  );

  //
  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(21.003556, 105.800515),
  //     zoom: 19.151926040649414);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   _markerStream.addValue(widget.listMarker);
    // });
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      // if (widget.listMarker.isNotEmpty) {
      //   _markerStream.addRawValue(widget.listMarker, context);
      // };
      if (widget.listMarker.isEmpty) return;
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(
          _boundsFromLatLngList(widget.listMarker.map((e) => e.latLng).toList()),
          50));
    });

    return Container(
      child: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            // cameraTargetBounds: _getBoundFromMarker(),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _customInfoWindowController.googleMapController = controller;
            },
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow?.call();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove?.call();
            },
            zoomControlsEnabled: false,
            markers: widget.listMarker.map((e) => Marker(
                markerId: MarkerId("${e.id}"),
                icon: BitmapDescriptor.fromBytes(e.image!),
                position: e.latLng,
                onTap: () {
                  _customInfoWindowController.addInfoWindow?.call(
                      _buildInforMarker(e),
                      e.latLng);
                })).toList().toSet(),
            mapToolbarEnabled: false,
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 80,
            width: 180,
            offset: 30,
          ),
        ],
      ),
    );
  }

  Widget _buildInforMarker(MapMarkerVM model) {
    return Container(
      width: 180,
      height: 75,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 13, right: 8, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorUtils.greenHome, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: TextNormal(
                content: model.place,
                maxLine: 3,
                size: 14,
              )),
              SizedBox(
                width: 8,
              ),
              Image.asset(
                ImageUtils.icGoogleMap,
                width: 27,
                height: 36,
              )
            ],
          ),
          SizedBox(
            height: 3,
          ),
          RippleInkWell(
            child: Padding(
              padding: EdgeInsets.only(right: 5, top: 5),
              child: TextNormal(
                content: S.of(context).view_order_detail,
                decoration: TextDecoration.underline,
                size: 14,
              ),
            ),
          )
        ],
      ),
    );
  }

  CameraTargetBounds _getBoundFromMarker() {
    if (widget.listMarker.isEmpty) return CameraTargetBounds.unbounded;
    return CameraTargetBounds(
      _boundsFromLatLngList((widget.listMarker.map((e) => e.latLng).toList()))
    );
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double x0 = list[0].latitude, x1 = list[0].latitude, y0 = list[0].longitude, y1= list[0].longitude;
    for (LatLng latLng in list) {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }

// Future<BitmapDescriptor> getCustomIcon(GlobalKey iconKey) async {
//   Future<Uint8List> _capturePng(GlobalKey iconKey) async {
//     try {
//       print('inside');
//       RenderObject? boundary = iconKey.currentContext!.findRenderObject();
//       ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
//       ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//       var pngBytes = byteData.buffer.asUint8List();
//       print(pngBytes);
//       return pngBytes;
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Uint8List imageData = await _capturePng(iconKey);
//   log("testIcon set");
//   return BitmapDescriptor.fromBytes(imageData);
// }
}
