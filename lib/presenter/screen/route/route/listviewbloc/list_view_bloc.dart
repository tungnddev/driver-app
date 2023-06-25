import 'package:driver/data/remote/exception/exception_mapper.dart';
import 'package:driver/presenter/models/route_list_view_vm.dart';
import 'package:driver/presenter/screen/route/route/listviewbloc/list_view_event.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_view_state.dart';

class RouteListViewBloc extends Bloc<RouteListViewEvent, RouteListViewState> {
  RouteListViewBloc()
      : super(RouteListViewLoading());

  @override
  Stream<RouteListViewState> mapEventToState(RouteListViewEvent event) async* {
    try {
      if (event is RouteListViewStartLoad) {
        yield RouteListViewLoading();
        RouteListViewVM vm = RouteListViewVM(
            event.dateTime.day == 7
                ? "Confirmed Route Dashboard"
                : "Confirmed Route Dashboard 222",
            event.dateTime.day == 7 ? "9:00 am" : "10:00 am",
            "141 mi",
            "\$85.00",
            [
              RouteListViewItemVM(
                  "Order 301201 Drop-Off",
                  "Mary Poppins",
                  "(818) 123 4567",
                  "54331 Branford St, Pacoima CA 91331",
                  "Drop-Off Time: 9:00 am",
                  "Complete",
                  Colors.white,
                  ColorUtils.blueDropOff,
                  Colors.black),
              RouteListViewItemVM(
                  "Order 301203 Drop-Off",
                  "Mary Poppins",
                  "(818) 123 4567",
                  "54331 Branford St, Pacoima CA 91331",
                  "Drop-Off Time: 9:00 am",
                  "Activate",
                  ColorUtils.greenHome,
                  ColorUtils.blueDropOff,
                  Colors.white),
              RouteListViewItemVM(
                  "Order 301204 Pick-Up",
                  "Mary Poppins",
                  "(818) 123 4567",
                  "54331 Branford St, Pacoima CA 91331",
                  "Pick-Up Time: 9:00 am",
                  "Activate",
                  ColorUtils.greenHome,
                  ColorUtils.pinkPickUp,
                  Colors.white),
              RouteListViewItemVM(
                  "Order 301205 Pick-Up",
                  "Mary Poppins",
                  "(818) 123 4567",
                  "54331 Branford St, Pacoima CA 91331",
                  "Pick-Up Time: 9:00 am",
                  "Activate",
                  ColorUtils.greenHome,
                  ColorUtils.pinkPickUp,
                  Colors.white),
              RouteListViewItemVM(
                  "Order 301206 Pick-Up",
                  "Mary Poppins",
                  "(818) 123 4567",
                  "54331 Branford St, Pacoima CA 91331",
                  "Pick-Up Time: 9:00 am",
                  "Activate",
                  ColorUtils.greenHome,
                  ColorUtils.pinkPickUp,
                  Colors.white),
              RouteListViewItemVM(
                  "Order 301207 Pick-Up",
                  "Mary Poppins",
                  "(818) 123 4567",
                  "54331 Branford St, Pacoima CA 91331",
                  "Pick-Up Time: 9:00 am",
                  "Activate",
                  ColorUtils.greenHome,
                  ColorUtils.pinkPickUp,
                  Colors.white),
              RouteListViewItemVM(
                  "Order 301208 Pick-Up",
                  "Mary Poppins",
                  "(818) 123 4567",
                  "54331 Branford St, Pacoima CA 91331",
                  "Pick-Up Time:  9:00 am",
                  "Activate",
                  ColorUtils.greenHome,
                  ColorUtils.pinkPickUp,
                  Colors.white)
            ]);
        await Future.delayed(Duration(seconds: 1));
        yield RouteListViewLoadSuccessful(vm);
      }
    } catch (e) {
      yield RouteListViewLoadFail(ExceptionMapper.map(e));
    }
  }
}
