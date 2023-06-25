import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/route_confirm_vm.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/divider.dart';
import 'package:driver/utils/widgets/expandable_view.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:driver/utils/extensions/date_time.dart';

class ItemConfirmRoute extends StatefulWidget {
  final RouteConfirmVM model;
  final int index;
  const ItemConfirmRoute({Key? key, required this.model, required this.index}) : super(key: key);

  @override
  _ItemConfirmRouteState createState() => _ItemConfirmRouteState();
}

class _ItemConfirmRouteState extends State<ItemConfirmRoute> {
  @override
  Widget build(BuildContext context) {
    return ExpandableView(childTitle: (isExpanding) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        children: [
          TextNormal(content: "${widget.index + 1}",),
          SizedBox(width: 10,),
          Expanded(child: TextNormal(content: "${S.of(context).order} ${widget.model.code}",)),
          SizedBox(width: 15,),
          RotatedBox(quarterTurns: isExpanding ? 0 : 2, child: Image.asset(ImageUtils.icCalendarArrowUp, width: 21, height: 13,),)
        ],
      ),
    ), childExpand:
    Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        // trick to straight content
        children: [
          Opacity(opacity: 0, child: Row(
            children: [
              TextNormal(content: "${widget.index + 1}",),
              SizedBox(width: 10,),
            ],
          ),),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    TextNormal(content: "${S.of(context).route_customer}: ", size: 14,),
                    Expanded(
                      child: RichText(text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black
                        ),
                        text: "${widget.model.customerName} ",
                        children: [
                          TextSpan(
                            text: widget.model.customerPhone,
                            style: TextStyle(
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              if (widget.model.customerPhone.isNotEmpty) {
                                launch("tel://" + widget.model.customerPhone);
                              }
                          }
                          )
                        ]
                      )),
                    )
                  ],
                ),
                SizedBox(height: 3,),
                Row(
                  children: [
                    TextNormal(content: "${S.of(context).route_address}: ", size: 14,),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {

                        },
                        child: TextNormal(
                          size: 14,
                          content: widget.model.address,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Image.asset(ImageUtils.icGoogleMap, width: 16, height: 20,),
                  ],
                ),
                SizedBox(height: 3,),
                TextNormal(
                  content: "${S.of(context).route_drop_of_time}: ${widget.model.timeDrop.toHour}",
                  size: 14,
                ),
                SizedBox(height: 8,),
              ],
            ),
          )
        ],
      ),
    ), childBottom: DividerApp(),
    );
  }
}
