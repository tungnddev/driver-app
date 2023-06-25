import 'dart:typed_data';

import 'package:driver/presenter/models/map_marker_vm.dart';
import 'package:driver/presenter/models/route_date_vm.dart';
import 'package:driver/presenter/screen/route/route/widgets/marker_generate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'map_view_event.dart';
import 'map_view_state.dart';
import 'package:collection/collection.dart';

class MapViewBloc extends Bloc<MapViewEvent, MapViewState> {
  BuildContext context;

  MapViewBloc(this.context) : super(MapViewInitial());

  @override
  Stream<MapViewState> mapEventToState(MapViewEvent event) async* {
    if (event is MapViewStartLoad) {
      // fake data
      bool isSameDate = DateTime.now().day == event.dateSelected.day;

      RouteDateVM vm = RouteDateVM(
          "Confirmed Route Dashboard",
          isSameDate ? "9:00 am" : "10:00 am",
          "141 mi",
          isSameDate ? "\$85.00" : "\$185.00",
          isSameDate
              ? [
                  MapMarkerVM(LatLng(34.064634, -118.233123), 0, 0,
                      "54331 Branford St, Pacoima CA 91331", Colors.red),
                  MapMarkerVM(LatLng(34.049170, -118.235644), 1, 1,
                      "54331 Branford St, Pacoima CA 91331", Colors.red),
                  MapMarkerVM(LatLng(34.054363, -118.254786), 2, 2,
                      "54331 Branford St, Pacoima CA 91331", Colors.green),
                  MapMarkerVM(LatLng(34.057806, -118.265891), 3, 3,
                      "54331 Branford St, Pacoima CA 91331", Colors.blue),
                  MapMarkerVM(LatLng(34.065932, -118.265822), 4, 4,
                      "54331 Branford St, Pacoima CA 91331", Colors.blue),
                  MapMarkerVM(LatLng(34.072100, -118.258045), 5, 5,
                      "54331 Branford St, Pacoima CA 91331", Colors.green),
                  MapMarkerVM(LatLng(34.073525, -118.242028), 6, 6,
                      "54331 Branford St, Pacoima CA 91331", Colors.green),
                  MapMarkerVM(LatLng(34.058722, -118.251823), 7, 7,
                      "54331 Branford St, Pacoima CA 91331", Colors.red),
                ]
              : [
                  MapMarkerVM(LatLng(34.062396, -118.242888), 0, 0,
                      "54331 Branford St, Pacoima CA 91331", Colors.green),
                  MapMarkerVM(LatLng(34.075280, -118.269428), 1, 1,
                      "54331 Branford St, Pacoima CA 91331", Colors.blue),
                  MapMarkerVM(LatLng(34.068999, -118.279906), 2, 2,
                      "54331 Branford St, Pacoima CA 91331", Colors.green),
                  MapMarkerVM(LatLng(34.055567, -118.277702), 3, 3,
                      "54331 Branford St, Pacoima CA 91331", Colors.green),
                  MapMarkerVM(LatLng(34.063730, -118.240462), 4, 4,
                      "54331 Branford St, Pacoima CA 91331", Colors.red),
                ]);
      MarkerGenerator(vm.listMarker.map((e) => e.widget).toList(),
          (List<Uint8List> list) {
        if (list.length == vm.listMarker.length) {
          vm.listMarker.forEachIndexed((index, element) {
            element.image = list[index];
          });
          add(MapViewLoadImageSuccess(vm));
        }
      }).generate(context);
    } else if (event is MapViewLoadImageSuccess) {
      yield MapViewLoadSuccessful(event.vm);
    }
  }
}
