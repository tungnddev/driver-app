import 'package:driver/data/remote/exception/exception_handler.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/pending_confirm_vm.dart';
import 'package:driver/presenter/models/route_confirm_vm.dart';
import 'package:driver/presenter/screen/calendar/widgets/list_month_horizontal.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/divider.dart';
import 'package:driver/utils/widgets/empty.dart';
import 'package:driver/utils/widgets/list_view.dart';
import 'package:driver/utils/widgets/loading_view.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'pending_route_bloc/pending_route_bloc.dart';
import 'pending_route_bloc/pending_route_event.dart';
import 'pending_route_bloc/pending_route_state.dart';
import 'widgets/header_routes.dart';
import 'widgets/item_pending_confirm.dart';
import 'widgets/list_date_horizontal.dart';

class CalendarOrderPending extends StatefulWidget {
  const CalendarOrderPending({Key? key}) : super(key: key);

  @override
  _CalendarOrderPendingState createState() => _CalendarOrderPendingState();
}

class _CalendarOrderPendingState extends State<CalendarOrderPending> {

  late PendingRouteBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<PendingRouteBloc>(context)..add(PendingRouteLoadList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HeaderRoute(
          color: ColorUtils.redPendingConfirm,
          text: S.of(context).pending_confirmation,
          child: ListDateHorizontal(
            colorSelected: ColorUtils.redPendingConfirm,
            onChange: (dateTime) {
              bloc.currentDateTime = dateTime;
              bloc.add(PendingRouteRefresh());
            },
          ),
        ),
        Expanded(
          child: BlocConsumer<PendingRouteBloc, PendingRouteState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is PendingRouteLoadFailed) {
                  AppExceptionHandle.handle(context, state.error);
                }
              },
              builder: (context, state) =>
                  _buildMainWidget(state)),
        ),
        DividerApp(),
        Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: DriverButton(
              textColor: Colors.black,
              backgroundColor: ColorUtils.grayBackButton,
              text: S.of(context).profile_back,
              onTap: () {

              },
            ))
      ],
    );
  }

  Widget _buildMainWidget(state) {
    if (state is PendingRouteLoadEmpty) {
      return NewEmptyViewRefresh(
          content: S.of(context).empty_list,
          onRefresh: () async {
            bloc.add(PendingRouteLoadList());
          });
    } else if (state is PendingRouteLoadSuccessful) {
      return ListViewLoadMoreAndRefresh<PendingConfirmVM>(
        list: state.listPendingRoute,
        item: (PendingConfirmVM item, int index) => ItemPendingConfirm(model: item, index: index, onAccept: () {}, onDecline: () {},),
        onLoadMore: () => bloc.add(PendingRouteLoadMore()),
        onRefresh: () => bloc.add(PendingRouteRefresh()),
      );
    }
    return LoadingView();
  }


}
