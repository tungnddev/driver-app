import 'package:driver/generated/l10n.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:flutter/material.dart';

import 'gesture_detector.dart';

class MessageAlertDialog extends StatelessWidget {
  String? title;
  String? message;
  Function? done;

  MessageAlertDialog({Key? key, this.title, this.message, this.done})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        margin: EdgeInsets.symmetric(horizontal: 40.0),
        padding:
            EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title ?? "",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              message ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: ColorUtils.colorText),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 48.0,
              child: Align(
                alignment: Alignment.centerRight,
                child: RippleInkWell(
                  onTap: () {
                    Navigator.pop(context);
                    if (done != null) {
                      done!();
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Text(
                      S.of(context).dialog_message_done_button.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
