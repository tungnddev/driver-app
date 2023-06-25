class CalendarOverviewEvent {
  const CalendarOverviewEvent();
}

class CalendarOverviewStartInitial extends CalendarOverviewEvent {
  final DateTime dateTime;
  const CalendarOverviewStartInitial(this.dateTime);
}

class CalendarOverviewChangeMonth extends CalendarOverviewEvent {
  final DateTime dateTime;
  const CalendarOverviewChangeMonth(this.dateTime);
}