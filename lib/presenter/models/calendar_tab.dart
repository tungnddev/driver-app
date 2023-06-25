import 'dart:ui';

import 'package:driver/generated/l10n.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:flutter/cupertino.dart';

enum CalendarTab { overview, confirmed, enterAvailability, pendingConfirm }

extension Convert on CalendarTab {
  Color get toColor {
    switch (this) {
      case CalendarTab.overview:
        return ColorUtils.grayUnSelectedTab;
      case CalendarTab.confirmed:
        return ColorUtils.greenHome;
      case CalendarTab.enterAvailability:
        return ColorUtils.colorBlueButton;
      case CalendarTab.pendingConfirm:
        return ColorUtils.redPendingConfirm;
    }
  }

  String stringDisplay(BuildContext context) {
    switch (this) {
      case CalendarTab.overview:
        return S.of(context).overview;
      case CalendarTab.confirmed:
        return S.of(context).confirmed_routes;
      case CalendarTab.enterAvailability:
        return S.of(context).enter_availability;
      case CalendarTab.pendingConfirm:
        return S.of(context).pending_confirmation;
    }
  }
}
