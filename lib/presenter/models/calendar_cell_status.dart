import 'package:driver/generated/l10n.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:flutter/material.dart';

enum CalendarCellStatus {
  previous_route, activate_route, pending, none
}

extension CovertColor on CalendarCellStatus {
  Color get colorInActivate {
    switch (this) {
      case CalendarCellStatus.previous_route:
        return ColorUtils.grayUnSelectedTab;
      case CalendarCellStatus.activate_route:
        return ColorUtils.greenDisable;
      case CalendarCellStatus.pending:
        return ColorUtils.redDisable;
      case CalendarCellStatus.none:
        return Colors.white;
    }
  }

  Color get colorActivate {
    switch (this) {
      case CalendarCellStatus.previous_route:
        return ColorUtils.grayUnSelectedTab;
      case CalendarCellStatus.activate_route:
        return ColorUtils.greenHome;
      case CalendarCellStatus.pending:
        return ColorUtils.redHome;
      case CalendarCellStatus.none:
        return Colors.white;
    }
  }

  String toStringDisplay(BuildContext context) {
    switch (this) {
      case CalendarCellStatus.previous_route:
        return S.of(context).previous_routes;
      case CalendarCellStatus.activate_route:
        return S.of(context).activate_routes;
      case CalendarCellStatus.pending:
        return S.of(context).pending_confirmation;
      case CalendarCellStatus.none:
        return "";
    }
  }
}