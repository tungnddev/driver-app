import 'package:driver/data/remote/exception/exception_handler.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/route_confirm_vm.dart';
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

import 'confirmed_routes_bloc/confirmed_route_bloc.dart';
import 'confirmed_routes_bloc/confirmed_route_event.dart';
import 'confirmed_routes_bloc/confirmed_route_state.dart';
import 'widgets/header_routes.dart';
import 'widgets/item_confirm_routes.dart';
import 'widgets/list_date_horizontal.dart';

class CalendarOrderConfirm extends StatefulWidget {
  const CalendarOrderConfirm({Key? key}) : super(key: key);

  @override
  _CalendarOrderConfirmState createState() => _CalendarOrderConfirmState();
}

class _CalendarOrderConfirmState extends State<CalendarOrderConfirm> {

  late ConfirmedRouteBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ConfirmedRouteBloc>(context)..add(ConfirmedRouteLoadList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HeaderRoute(
          color: ColorUtils.greenHome,
          text: S.of(context).confirmed_routes,
          child: ListDateHorizontal(
            colorSelected: ColorUtils.greenHome,
            onChange: (dateTime) {
              bloc.currentDateTime = dateTime;
              bloc.add(ConfirmedRouteRefresh());
            },
          ),
        ),
        Expanded(
          child: BlocConsumer<ConfirmedRouteBloc, ConfirmedRouteState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is ConfirmedRouteLoadFailed) {
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
    if (state is ConfirmedRouteLoadEmpty) {
      return NewEmptyViewRefresh(
          content: S.of(context).empty_list,
          onRefresh: () async {
            bloc.add(ConfirmedRouteLoadList());
          });
    } else if (state is ConfirmedRouteLoadSuccessful) {
      return ListViewLoadMoreAndRefresh<RouteConfirmVM>(
        list: state.listConfirmedRoute,
        item: (RouteConfirmVM item, int index) => ItemConfirmRoute(model: item, index: index,),
        onLoadMore: () => bloc.add(ConfirmedRouteLoadMore()),
        onRefresh: () => bloc.add(ConfirmedRouteRefresh()),
      );
    }
    return LoadingView();
  }


}
