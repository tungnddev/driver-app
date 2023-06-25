import 'dart:async';

import 'package:driver/presenter/models/calendar_tab.dart';

class CalendarTabStream {
  StreamController<CalendarTab> _streamController = StreamController.broadcast();

  get stream => _streamController.stream;

  void addValue(CalendarTab tab) {
    _streamController.add(tab);
  }

  void close() {
    _streamController.close();
  }
}
