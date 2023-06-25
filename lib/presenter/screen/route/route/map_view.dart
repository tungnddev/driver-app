import 'dart:async';

import 'package:driver/presenter/models/map_marker_vm.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'mapviewbloc/map_view_bloc.dart';
import 'mapviewbloc/map_view_event.dart';
import 'mapviewbloc/map_view_state.dart';
import 'widgets/date_route_widget.dart';
import 'widgets/map_view_widget.dart';
import 'widgets/paint_draw_marker.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  DateTime currentDate = DateTime.now();
  late MapViewBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of<MapViewBloc>(context)
      ..add(MapViewStartLoad(currentDate));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapViewBloc, MapViewState>(
      bloc: bloc,
      listener: (context, state) {},
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 44,
              child: MapViewWidget(
            listMarker:
                state is MapViewLoadSuccessful ? state.vm.listMarker : [],
          )),
          Expanded(
            flex: 58,
              child: DateRouteWidget(
            dateTime: currentDate,
            state: state,
            onNext: () {
              currentDate = currentDate.add(Duration(days: 1));
              bloc.add(MapViewStartLoad(currentDate));
            },
            onPrevious: () {
              currentDate = currentDate.subtract(Duration(days: 1));
              bloc.add(MapViewStartLoad(currentDate));
            },
          ))
        ],
      ),
    );
  }
}
