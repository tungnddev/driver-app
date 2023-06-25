import 'package:driver/presenter/models/calendar_cell_status.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarOverviewWidget extends StatefulWidget {
  final Map<String, CalendarCellStatus> listStatus;
  final Function(DateTime dateTime)? onChangeDate;
  final Function(DateTime dateTime)? onChangeMonth;

  const CalendarOverviewWidget(
      {Key? key,
      required this.listStatus,
      this.onChangeDate,
      this.onChangeMonth})
      : super(key: key);

  @override
  _CalendarOverviewWidgetState createState() => _CalendarOverviewWidgetState();
}

class _CalendarOverviewWidgetState extends State<CalendarOverviewWidget> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final duration = const Duration(milliseconds: 250);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TableCalendar(
        onPageChanged: (dateTime) {
          _focusDay = dateTime;
          widget.onChangeMonth?.call(dateTime);
        },
        firstDay: DateTime.utc(1000, 10, 16),
        lastDay: DateTime.utc(3000, 3, 14),
        focusedDay: _focusDay,
        locale: Localizations.localeOf(context).languageCode,
        weekendDays: [],
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        },
        headerStyle: HeaderStyle(titleCentered: true),
        rowHeight: (MediaQuery.of(context).size.width - 2 * 15) / 7,
        calendarStyle: CalendarStyle(
          outsideTextStyle:
              TextStyle(fontSize: 13, color: ColorUtils.dayDisable),
          outsideDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(width: 0.7, color: ColorUtils.dayDisable)),
          // defaultTextStyle: TextStyle(fontSize: 13, color: Colors.black),
          // defaultDecoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(4),
          //     border: Border.all(width: 0.7, color: ColorUtils.colorTextHint)),
          cellMargin: const EdgeInsets.all(3.2),
          isTodayHighlighted: false,
        ),
        calendarBuilders: CalendarBuilders(dowBuilder: (context, day) {
          final weekdayString =
              DateFormat.E(Localizations.localeOf(context).languageCode)
                  .format(day);

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.2),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: ColorUtils.orangeHome),
              alignment: Alignment.center,
              child: Text(weekdayString,
                  style: TextStyle(color: Colors.black, fontSize: 13)),
            ),
          );
        }, defaultBuilder:
            (BuildContext context, DateTime day, DateTime focusedDay) {
          return AnimatedContainer(
            duration: duration,
            margin: const EdgeInsets.all(3.2),
            decoration: BoxDecoration(
                color: widget.listStatus[DateFormat("dd/MM/yyyy").format(day)]
                        ?.colorInActivate ??
                    Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    width: 0.7, color: ColorUtils.grayUnSelectedTab)),
            alignment: Alignment.center,
            child: Text(
              '${day.day}',
              style: TextStyle(fontSize: 13, color: Colors.black),
            ),
          );
        }, selectedBuilder:
            (BuildContext context, DateTime day, DateTime focusedDay) {
          return AnimatedContainer(
            duration: duration,
            margin: const EdgeInsets.all(3.2),
            decoration: BoxDecoration(
                color: widget.listStatus[DateFormat("dd/MM/yyyy").format(day)]
                        ?.colorActivate ??
                    Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 2.5, color: ColorUtils.borderBold)),
            alignment: Alignment.center,
            child: Text(
              '${day.day}',
              style: TextStyle(fontSize: 13, color: Colors.black),
            ),
          );
        }),
        daysOfWeekHeight: 22,
        selectedDayPredicate: (day) {
          return isSameDay(day, _selectedDay);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusDay = focusedDay;
          });
          widget.onChangeDate?.call(_selectedDay);
        },
      ),
    );
  }
}
