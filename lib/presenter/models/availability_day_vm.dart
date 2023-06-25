import 'package:driver/utils/define/colors.dart';
import 'package:flutter/material.dart';

class AvailabilityVM {
  AvailableType type;
  String note;
  DateTime dateTime;
  bool isSelecting;

  AvailabilityVM(this.type, this.note, this.dateTime, this.isSelecting);
}

enum AvailableType {
  whole_day, half_day, not_available, none
}

extension ConvertToColor on AvailableType {
  Color toColor() {
    switch (this) {
      case AvailableType.whole_day:
      case AvailableType.half_day:
        return ColorUtils.colorBlueButton;
      case AvailableType.not_available:
        return ColorUtils.redNotAvailable;
      case AvailableType.none:
        return Colors.white;
    }
  }
}