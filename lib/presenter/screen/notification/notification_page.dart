import 'package:driver/data/remote/exception/exception_handler.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/notification_vm.dart';
import 'package:driver/presenter/screen/notification/bloc/notification_bloc.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/app_bar.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/empty.dart';
import 'package:driver/utils/widgets/list_view.dart';
import 'package:driver/utils/widgets/loading_view.dart';
import 'package:driver/utils/widgets/scaffold_with_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/notification_event.dart';
import 'bloc/notification_state.dart';
import 'widget/item_notification.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => NotificationBloc(context: context))
    ], child: NotificationWidget());
  }
}

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  late NotificationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<NotificationBloc>(context)..add(NotificationLoadList());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithColor(
      color: ColorUtils.redHome,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DriverAppBar(
                asset: ImageUtils.icAppBarNotification ,
                title: S.of(context).home_notification,
                color: ColorUtils.redHome,
            sizeIcon: 32 ,),
            Expanded(
              child: BlocConsumer<NotificationBloc, NotificationState>(
                  bloc: bloc,
                  listener: (context, state) {
                    if (state is NotificationLoadFailed) {
                      AppExceptionHandle.handle(context, state.error);
                    }
                  },
                  builder: (context, state) =>
                      _buildMainWidget(state)),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: DriverButton(
                  textColor: Colors.black,
                  backgroundColor: Color(0xFFD3D3D3),
                  text: S.of(context).profile_back,
                  onTap: () {},
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildMainWidget(state) {
    if (state is NotificationLoadEmpty) {
      return NewEmptyViewRefresh(
          content: S.of(context).empty_list,
          onRefresh: () async {
            bloc.add(NotificationLoadList());
          });
    } else if (state is NotificationLoadSuccessful) {
      return ListViewLoadMoreAndRefresh<NotificationVM>(
        list: state.listNotification,
        item: (NotificationVM item, int index) => ItemNotification(model: item),
        onLoadMore: () => bloc.add(NotificationLoadMore()),
        onRefresh: () => bloc.add(NotificationRefresh()),
      );
    }
    return LoadingView();
  }
}
