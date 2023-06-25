import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/availability_day_vm.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/divider.dart';
import 'package:driver/utils/widgets/expandable_view.dart';
import 'package:driver/utils/widgets/gesture_detector.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemAvailability extends StatefulWidget {
  final AvailabilityVM model;
  final Function()? onChangeSelected;

  const ItemAvailability({Key? key, required this.model, this.onChangeSelected}) : super(key: key);

  @override
  _ItemAvailabilityState createState() => _ItemAvailabilityState();
}

class _ItemAvailabilityState extends State<ItemAvailability> {
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.model.note);
  }

  @override
  Widget build(BuildContext context) {
    _noteController.text = widget.model.note;
    return ExpandableView(
      childTitle: (isExpanding) => _buildTitle(isExpanding),
      childExpand: _buildNoteWidget(),
      childBottom: DividerApp(),
    );
  }

  _buildTitle(bool isExpanding) => Padding(
        padding: const EdgeInsets.only(top: 13, bottom: 13, right: 10, left: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RippleInkWell(
              onTap: () {
                setState(() {
                  widget.model.isSelecting = !widget.model.isSelecting;
                });
                widget.onChangeSelected?.call();
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  widget.model.isSelecting
                      ? ImageUtils.icCheck
                      : ImageUtils.icUnCheck,
                  width: 13,
                  height: 13,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            TextNormal(
              content: widget.model.dateTime.day.toString(),
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            TextNormal(
              content: DateFormat("MMM").format(widget.model.dateTime),
              size: 12,
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
    return Padding(
      padding: EdgeInsets.only(left: 95, right: 44, bottom: 10),
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorUtils.colorBorderNote, width: 1)),
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
              controller: _noteController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(fontSize: 13),
              decoration: InputDecoration(
                  hintText: S.of(context).hint_notes_availability,
                  hintStyle:
                      TextStyle(fontSize: 13, color: ColorUtils.colorTextHint),
                  counter: SizedBox(
                    width: 0,
                    height: 0,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero),
              onChanged: (text) {
                widget.model.note = text.trim();
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildChip(String content, AvailableType availableType) {
    return RippleInkWell(
      onTap: () {
        setState(() {
          if (widget.model.type != availableType) {
            widget.model.type = availableType;
          } else {
            widget.model.type = AvailableType.none;
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
              color: widget.model.type == availableType
                  ? availableType.toColor()
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: widget.model.type == availableType
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
