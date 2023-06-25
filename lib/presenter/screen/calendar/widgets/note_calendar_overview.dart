import 'package:driver/presenter/models/calendar_cell_status.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';

class NoteCalendarOverview extends StatelessWidget {
  const NoteCalendarOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildItemNote(CalendarCellStatus.previous_route, context),
            _buildItemNote(CalendarCellStatus.activate_route, context)
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildItemNote(CalendarCellStatus.pending, context)
          ],
        )
      ],
    ),);
  }

  Widget _buildItemNote(CalendarCellStatus status, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: status.colorInActivate,
              width: 14,
              height: 14,
            ),
            SizedBox(width: 7,),
            Expanded(
              child: TextNormal(
                color: status.colorInActivate,
                content: status.toStringDisplay(context),
                size: 13,
              ),
            ),
            SizedBox(width: 7,),
          ],
        ),
      ),
    );
  }

}
