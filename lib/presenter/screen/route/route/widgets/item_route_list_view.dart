import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/route_list_view_vm.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/divider.dart';
import 'package:driver/utils/widgets/expandable_view.dart';
import 'package:driver/utils/widgets/small_button.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemRouteListView extends StatelessWidget {
  final RouteListViewItemVM model;
  final int index;
  final Function()? onTap;

  const ItemRouteListView({Key? key, required this.index, required this.model, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: model.bgColor,
      child: ExpandableView(
        childTitle: (isExpanding) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Row(
            children: [
              TextNormal(
                content: "${index + 1}",
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: TextNormal(
                content: "${model.title}",
                    size: 13,
                    maxLine: 1,
              )),
              _buildStatusTag(),
              SizedBox(
                width: 50,
              ),
              RotatedBox(
                quarterTurns: isExpanding ? 0 : 2,
                child: Image.asset(
                  ImageUtils.icArrowUpWhite,
                  width: 21,
                  height: 13,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        childExpand: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Row(
            // trick to straight content
            children: [
              Opacity(
                opacity: 0,
                child: Row(
                  children: [
                    TextNormal(
                      content: "${index + 1}",
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextNormal(
                      content:
                          "${S.of(context).route_customer}: ${model.customerName}",
                      size: 12,
                    ),
                    SizedBox(height: 3,),
                    InkWell(
                      onTap: () {
                        if (model.customerPhone.isNotEmpty) {
                          launch("tel://" +
                              model.customerPhone
                                  .replaceAll("(", "")
                                  .replaceAll(")", "")
                                  .replaceAll(" ", ""));
                        }
                      },
                      child: TextNormal(
                        decoration: TextDecoration.underline,
                        content:
                            "${S.of(context).phone}: ${model.customerPhone}",
                        size: 12,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        TextNormal(
                          content: "${S.of(context).route_address}: ",
                          size: 12,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: TextNormal(
                              size: 12,
                              content: model.address,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          ImageUtils.icGoogleMap,
                          width: 16,
                          height: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    TextNormal(
                      content: "${model.timeLine}",
                      size: 12,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: DriverSmallButton(
                        text: S.of(context).view_order_detail,
                        backgroundColor: ColorUtils.orangeHome,
                        onTap: onTap,
                        textColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        childBottom: DividerApp(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStatusTag() => Container(
      width: 80,
      height: 20,
      alignment: Alignment.center,
      child: TextNormal(
        size: 13,
        color: model.colorTextStatus,
        content: model.status,
        maxLine: 1,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: model.colorStatus));
}
