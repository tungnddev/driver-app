import 'dart:ui';

import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/calendar_tab.dart';
import 'package:driver/presenter/screen/calendar/availability_bloc/availability_bloc.dart';
import 'package:driver/presenter/screen/calendar/bloc/calendar_bloc.dart';
import 'package:driver/presenter/screen/calendar/bloc/calendar_event.dart';
import 'package:driver/presenter/screen/calendar/calendar_order_pending.dart';
import 'package:driver/presenter/screen/calendar/calendar_order_confirm.dart';
import 'package:driver/presenter/screen/calendar/confirmed_routes_bloc/confirmed_route_bloc.dart';
import 'package:driver/presenter/screen/calendar/pending_route_bloc/pending_route_bloc.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/app_bar.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/divider.dart';
import 'package:driver/utils/widgets/gesture_detector.dart';
import 'package:driver/utils/widgets/scaffold_with_color.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/calendar_state.dart';
import 'calendar_availability.dart';
import 'calendar_over_view.dart';
import 'calendar_overview_bloc/calendar_overview_bloc.dart';
import 'stream/tab_calendar_stream.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => CalendarBloc()),
      BlocProvider(create: (context) => ConfirmedRouteBloc(context: context)),
      BlocProvider(create: (context) => PendingRouteBloc(context: context)),
      BlocProvider(create: (context) => AvailabilityBloc(context: context)),
      BlocProvider(create: (context) => CalendarOverviewBloc())
    ], child: CalendarWidget());
  }
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarTabStream tabStream = CalendarTabStream();
  CalendarTab currentTab = CalendarTab.overview;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabStream.close();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithColor(
      color: ColorUtils.orangeHome,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DriverAppBar(
                asset: ImageUtils.icAppBarCalendar,
                title: S.of(context).home_calendar,
                color: ColorUtils.orangeHome),
        StreamBuilder<CalendarTab>(
            stream: tabStream.stream,
            builder: (context, snapshot) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 14,),
                    Row(
                      children: [
                        SizedBox(width: 12,),
                        _buildTab(CalendarTab.overview),
                        SizedBox(width: 5,),
                        _buildTab(CalendarTab.confirmed),
                        SizedBox(width: 5,),
                        _buildTab(CalendarTab.enterAvailability),
                        SizedBox(width: 5,),
                        _buildTab(CalendarTab.pendingConfirm),
                        SizedBox(width: 12,)
                      ],
                    ),
                    SizedBox(height: 14,),
                    DividerApp(),
                    SizedBox(height: 5,),
                    Expanded(child: _buildMainWidget(snapshot.data ?? CalendarTab.overview))
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(CalendarTab tab) => Expanded(
      child: RippleInkWell(
        onTap: () {
          currentTab = tab;
          tabStream.addValue(tab);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 20),
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tab.toColor,
            borderRadius: BorderRadius.circular(12),
            border: tab == currentTab ? Border.all(color: ColorUtils.borderTabCalendar, width: 3) : null
          ),
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: TextNormal(
            content:
            tab.stringDisplay(context),
            size: 13,
            align: TextAlign.center,
            maxLine: 2,
          ),
        ),
      ));

  Widget _buildMainWidget(CalendarTab tab) {
    switch (tab) {
      case CalendarTab.overview:
        return CalendarOverview();
      case CalendarTab.confirmed:
        return CalendarOrderConfirm();
      case CalendarTab.enterAvailability:
        return CalendarAvailability();
      case CalendarTab.pendingConfirm:
        return CalendarOrderPending();
    }
  }
}
