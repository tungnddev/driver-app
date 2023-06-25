import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/availability_day_vm.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/divider.dart';
import 'package:driver/utils/widgets/expandable_view.dart';
import 'package:driver/utils/widgets/gesture_detector.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemAvailabilityCheck extends StatefulWidget {
  final Function(AvailableType availableType, String note)? onApply;

  const ItemAvailabilityCheck({Key? key, this.onApply}) : super(key: key);

  @override
  _ItemAvailabilityCheckState createState() => _ItemAvailabilityCheckState();
}

class _ItemAvailabilityCheckState extends State<ItemAvailabilityCheck> {
  AvailableType currentAvailableType = AvailableType.none;
  String currentNote = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableView(
      childTitle: (isExpanding) => _buildTitle(isExpanding),
      childExpand: _buildNoteWidget(),
    );
  }

  _buildTitle(bool isExpanding) => Container(
        color: ColorUtils.orangeApplyToSelected,
        padding: const EdgeInsets.only(top: 13, bottom: 13, right: 10, left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 70,
              alignment: Alignment.topCenter,
              child: TextNormal(
                content: S.of(context).apply_to_selected,
                size: 13,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: _buildChip(
                    S.of(context).whole_day, AvailableType.whole_day)),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child:
                    _buildChip(S.of(context).half_day, AvailableType.half_day)),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: _buildChip(
                    S.of(context).not_available, AvailableType.not_available)),
            SizedBox(
              width: 12,
            ),
            RotatedBox(
              quarterTurns: isExpanding ? 0 : 2,
              child: Image.asset(
                ImageUtils.icCalendarArrowUp,
                width: 21,
                height: 13,
              ),
            )
          ],
        ),
      );

  _buildNoteWidget() {
    return Container(
      color: ColorUtils.orangeApplyToSelected,
      padding: EdgeInsets.only(left: 95, right: 44, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 60,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: ColorUtils.colorBorderNote, width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextNormal(
                    content: S.of(context).notes,
                    size: 13,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(fontSize: 13),
                    decoration: InputDecoration(
                        hintText: S.of(context).hint_notes_availability,
                        hintStyle: TextStyle(
                            fontSize: 13, color: ColorUtils.colorTextHint),
                        counter: SizedBox(
                          width: 0,
                          height: 0,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero),
                    onChanged: (text) {
                      currentNote = text.trim();
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            child: DriverButton(
              onTap: () {
                widget.onApply?.call(currentAvailableType, currentNote);
              },
              text: S.of(context).apply_button,
              backgroundColor: ColorUtils.colorApplyButton,
            ),
            width: 65,
          )
        ],
      ),
    );
  }

  _buildChip(String content, AvailableType availableType) {
    return RippleInkWell(
      onTap: () {
        setState(() {
          if (currentAvailableType != availableType) {
            currentAvailableType = availableType;
          } else {
            currentAvailableType = AvailableType.none;
          }
        });
      },
      child: PhysicalModel(
        color: Colors.black,
        elevation: 1.5,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 36,
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
          decoration: BoxDecoration(
              color: currentAvailableType == availableType
                  ? availableType.toColor()
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: currentAvailableType == availableType
                      ? availableType.toColor()
                      : ColorUtils.colorBorderNote,
                  width: 0.5)),
          alignment: Alignment.center,
          child: TextNormal(
            content: content,
            maxLine: 2,
            size: 12.5,
            align: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
