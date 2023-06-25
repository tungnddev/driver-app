import 'package:driver/generated/l10n.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:flutter/cupertino.dart';

enum PackingSlipType {
  load, unLoad
}

extension Convert on PackingSlipType {
  String title(BuildContext context) {
    switch (this) {
      case PackingSlipType.load:
        return S.of(context).load_list;
      case PackingSlipType.unLoad:
        return S.of(context).un_load_list;
    }
  }

  Color get colorTitle {
    switch (this) {
      case PackingSlipType.load:
        return ColorUtils.yellowSelectedTab;
      case PackingSlipType.unLoad:
        return ColorUtils.colorUnLoadList;
    }
  }
}