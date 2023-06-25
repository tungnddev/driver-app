import 'package:driver/presenter/models/calendar_cell_status.dart';

class CalendarOverviewState {
  const CalendarOverviewState();
}

class CalendarOverviewInitial extends CalendarOverviewState {
  const CalendarOverviewInitial();
}

class CalendarOverviewLoadInitial extends CalendarOverviewState {
  final DateTime dateTime;
  const CalendarOverviewLoadInitial(this.dateTime);
}

class CalendarOverviewLoading extends CalendarOverviewState {
  const CalendarOverviewLoading();
}

class CalendarOverviewLoadSuccessful extends CalendarOverviewState {
  final Map<String, CalendarCellStatus> listDateCalendar;
  final Map<String, List<dynamic>> listOverview;
  const CalendarOverviewLoadSuccessful(this.listDateCalendar, this.listOverview);
}