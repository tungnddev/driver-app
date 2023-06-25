import 'dart:async';

import 'package:driver/presenter/models/calendar_cell_status.dart';

class ChangeDateOverviewStream {
  StreamController _streamController = StreamController<ChangeDateData>();

  get stream => _streamController.stream;

  void close() {
    _streamController.close();
  }

  void addValue(ChangeDateData data ) {
    _streamController.add(data);
  }
}

class ChangeDateData {
  List<dynamic> list;
  DateTime dateTimeSelected;
  CalendarCellStatus status;
  ChangeDateData({required this.list, required this.dateTimeSelected, required this.status});
}