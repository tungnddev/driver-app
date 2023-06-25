import 'dart:collection';

import 'package:driver/presenter/models/activate_route_vm.dart';
import 'package:driver/presenter/models/calendar_cell_status.dart';
import 'package:driver/presenter/models/pending_confirm_overview_vm.dart';
import 'package:driver/presenter/models/pending_confirm_vm.dart';
import 'package:driver/presenter/screen/calendar/calendar_overview_bloc/calendar_overview_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'calendar_oveview_state.dart';

class CalendarOverviewBloc
    extends Bloc<CalendarOverviewEvent, CalendarOverviewState> {
  CalendarOverviewBloc() : super(CalendarOverviewInitial());

  Map<String, CalendarCellStatus> lastListCell = HashMap();
  Map<String, List<dynamic>> listOverview = HashMap();

  @override
  Stream<CalendarOverviewState> mapEventToState(
      CalendarOverviewEvent event) async* {
    if (event is CalendarOverviewStartInitial) {
      yield* loadRoute(event.dateTime, isInit: true);
    } else if (event is CalendarOverviewChangeMonth) {
      yield* loadRoute(event.dateTime);
    }
  }

  Stream<CalendarOverviewState> loadRoute(DateTime dateTime, {bool isInit = false}) async* {
    yield CalendarOverviewLoading();
    lastListCell.clear();
    listOverview.clear();
    if (dateTime.month == 6) {
      lastListCell["20/06/2023"] = CalendarCellStatus.previous_route;
      lastListCell["21/06/2023"] = CalendarCellStatus.previous_route;
      lastListCell["22/06/2023"] = CalendarCellStatus.activate_route;
      lastListCell["23/06/2023"] = CalendarCellStatus.activate_route;
      lastListCell["24/06/2023"] = CalendarCellStatus.activate_route;
      lastListCell["27/06/2023"] = CalendarCellStatus.pending;
      listOverview["22/06/2023"] = [
        ActivateRouteVM("Order 20124 Drop-Off", "141 mi", "\$85.00", "\$20.00"),
        ActivateRouteVM(
            "Order 20124 - Completed", "141 mi", "\$85.00", "\$20.00"),
        ActivateRouteVM(
            "Order 20124 - Completed", "141 mi", "\$85.00", "\$20.00"),
        ActivateRouteVM(
            "Order 20124 - Completed", "141 mi", "\$85.00", "\$20.00")
      ];
      listOverview["27/06/2023"] = [
        PendingConfirmOverviewVM(
            "Glendale Pickup", "6 Orders", "141 mi", "\$20.00"),
        PendingConfirmOverviewVM(
            "Panorama Drop-Off", "6 Orders", "141 mi", "\$20.00"),
        PendingConfirmOverviewVM(
            "Glendale Pickup", "6 Orders", "141 mi", "\$20.00"),
        PendingConfirmOverviewVM(
            "Glendale Pickup", "6 Orders", "141 mi", "\$20.00"),
      ];
    } else if (dateTime.month == 8) {
      lastListCell["20/08/2021"] = CalendarCellStatus.previous_route;
      lastListCell["24/08/2021"] = CalendarCellStatus.activate_route;
      lastListCell["27/08/2021"] = CalendarCellStatus.pending;
      listOverview["24/08/2021"] = [
        ActivateRouteVM("Order 20124 Drop-Off", "141 mi", "\$85.00", "\$20.00"),
        ActivateRouteVM(
            "Order 20124 - Completed", "141 mi", "\$85.00", "\$20.00"),
        ActivateRouteVM(
            "Order 20124 - Completed", "141 mi", "\$85.00", "\$20.00"),
        ActivateRouteVM(
            "Order 20124 - Completed", "141 mi", "\$85.00", "\$20.00")
      ];
      listOverview["27/08/2021"] = [
        PendingConfirmOverviewVM(
            "Glendale Pickup", "6 Orders", "141 mi", "\$20.00"),
        PendingConfirmOverviewVM(
            "Panorama Drop-Off", "6 Orders", "141 mi", "\$20.00"),
        PendingConfirmOverviewVM(
            "Glendale Pickup", "6 Orders", "141 mi", "\$20.00"),
        PendingConfirmOverviewVM(
            "Glendale Pickup", "6 Orders", "141 mi", "\$20.00"),
      ];
    }
    // await Future.delayed(Duration(milliseconds: 500));
    yield CalendarOverviewLoadSuccessful(lastListCell, listOverview);
    if (isInit) {
      yield CalendarOverviewLoadInitial(dateTime);
    }
  }
}
