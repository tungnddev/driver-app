import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/notification_home_vm.dart';
import 'package:driver/presenter/screen/home/notification_bloc/notification_home_state.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/widgets/error_view.dart';
import 'package:driver/utils/widgets/loading_view.dart';
import 'package:driver/utils/widgets/shadow.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeNotification extends StatelessWidget {
  final NotificationHomeState state;

  const HomeNotification({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return PhysicalModel(
      color: Colors.black,
      borderRadius: BorderRadius.circular(8),
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white),
        child: _buildChildWidget(context, state)
      ),
    );
  }

  _buildChildWidget(BuildContext context, NotificationHomeState state) {
    if (state is NotificationHomeLoadSuccess) {
      List<NotificationHomeVM> list = state.list;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          TextNormal(
            content: S.of(context).home_notification,
            color: ColorUtils.redHome,
            size: 14,
            fontWeight: TextNormal.MEDIUM,
          ),
          SizedBox(
            height: 10,
          ),
          ListView.builder(
            itemBuilder: (context, index) =>
                _buildItemNotificationHome(list[index]),
            itemCount: list.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          )
        ],
      );
    }
    if (state is NotificationHomeLoading) {
      return Container(
        height: 184,
        child: LoadingView(strokeWidth: 2.5, size: 20,),
      );
    }

    if (state is NotificationHomeLoadError) {
      return Container(
        height: 184,
        child: ErrorView(),
      );
    }

    return SizedBox(
      height: 184,
    );
  }

  _buildItemNotificationHome(NotificationHomeVM model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(height: 1, color: ColorUtils.colorDivider,),
        SizedBox(height: 8,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 13,),
            Image.asset(model.assetIcon, width: 20, height: 20,),
            SizedBox(width: 16,),
            Expanded(child: TextNormal(
              size: 13,
              maxLine: 1,
              content: model.content,
            )),
            SizedBox(width: 10,),
          ],
        ),
        SizedBox(height: 8,),
      ],
    );
  }
}
