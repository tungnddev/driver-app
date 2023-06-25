import 'dart:collection';

import 'package:driver/presenter/models/activate_route_vm.dart';
import 'package:driver/presenter/models/calendar_cell_status.dart';
import 'package:driver/presenter/models/pending_confirm_overview_vm.dart';
import 'package:driver/presenter/screen/calendar/calendar_overview_bloc/calendar_overview_bloc.dart';
import 'package:driver/presenter/screen/calendar/calendar_overview_bloc/calendar_oveview_state.dart';
import 'package:driver/presenter/screen/calendar/widgets/item_activate_route.dart';
import 'package:driver/presenter/screen/calendar/widgets/item_pending_confirm_overview.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'calendar_overview_bloc/calendar_overview_event.dart';
import 'stream/apply_to_select_stream.dart';
import 'stream/change_date_overview_stream.dart';
import 'widgets/calendar_overview_widget.dart';
import 'widgets/note_calendar_overview.dart';

class CalendarOverview extends StatefulWidget {
  const CalendarOverview({Key? key}) : super(key: key);

  @override
  _CalendarOverviewState createState() => _CalendarOverviewState();
}

class _CalendarOverviewState extends State<CalendarOverview> {
  late CalendarOverviewBloc bloc;
  ChangeDateOverviewStream _changeDateOverviewStream =
      ChangeDateOverviewStream();

  @override
  void dispose() {
    _changeDateOverviewStream.close();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of<CalendarOverviewBloc>(context)
      ..add(CalendarOverviewStartInitial(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocConsumer<CalendarOverviewBloc, CalendarOverviewState>(
            listener: (context, state) {
              if (state is CalendarOverviewLoadInitial) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  String dateTime =
                      DateFormat("dd/MM/yyyy").format(state.dateTime);
                  _changeDateOverviewStream.addValue(ChangeDateData(
                      list: bloc.listOverview[dateTime] ?? [],
                      dateTimeSelected: state.dateTime,
                      status: bloc.lastListCell[dateTime] ??
                          CalendarCellStatus.none));
                });
              }
            },
            bloc: bloc,
            buildWhen: (pre, next) => next is CalendarOverviewLoadSuccessful,
            builder: (context, state) {
              if (state is CalendarOverviewLoadSuccessful) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CalendarOverviewWidget(
                      listStatus: state.listDateCalendar,
                      onChangeDate: (dateTime) {
                        String dateTimeString =
                            DateFormat("dd/MM/yyyy").format(dateTime);
                        _changeDateOverviewStream.addValue(ChangeDateData(
                            list: bloc.listOverview[dateTimeString] ?? [],
                            dateTimeSelected: dateTime,
                            status: bloc.lastListCell[dateTimeString] ??
                                CalendarCellStatus.none));
                      },
                      onChangeMonth: (dateTime) {
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          bloc.add(CalendarOverviewChangeMonth(dateTime));
                        });
                      },
                    ),
                  ],
                );
              }
              return Container();
            }),
        NoteCalendarOverview(),
        Expanded(
          child: StreamBuilder(
            stream: _changeDateOverviewStream.stream,
            builder:
                (BuildContext context, AsyncSnapshot<ChangeDateData> snapshot) {
              if (snapshot.data != null) {
                ChangeDateData data = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLineStatus(data.dateTimeSelected, data.status),
                    Expanded(child: _buildListRoutes(data.list))
                  ],
                );
              }
              return SizedBox();
            },
          ),
        )
      ],
    );
  }

  _buildLineStatus(DateTime dateTime, CalendarCellStatus status) {
    if (status == CalendarCellStatus.none) return SizedBox();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 27, vertical: 16),
      color: status.colorActivate,
      child: TextNormal(
        size: 13,
        content:
            "${status.toStringDisplay(context)} - ${DateFormat("MMMM dd, yyyy").format(dateTime)}",
      ),
    );
  }

  _buildListRoutes(List<dynamic> list) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var item = list[index];
        if (item is ActivateRouteVM) {
          return ItemActivateRoute(model: item, index: index, onDetail: () {},);
        } else if (item is PendingConfirmOverviewVM) {
          return ItemPendingConfirmOverview(model: item, index: index, onDecline: (){}, onAccept: () {},);
        }
        return SizedBox();
      },
      itemCount: list.length,
    );
  }
}
