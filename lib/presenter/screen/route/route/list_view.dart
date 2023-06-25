import 'package:driver/data/remote/exception/exception_handler.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/route_list_view_vm.dart';
import 'package:driver/presenter/screen/route/route/widgets/item_route_list_view.dart';
import 'package:driver/routes/routes.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/divider.dart';
import 'package:driver/utils/widgets/gesture_detector.dart';
import 'package:driver/utils/widgets/loading_view.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'listviewbloc/list_view_bloc.dart';
import 'listviewbloc/list_view_event.dart';
import 'listviewbloc/list_view_state.dart';

class RouteListView extends StatefulWidget {
  const RouteListView({Key? key}) : super(key: key);

  @override
  _RouteListViewState createState() => _RouteListViewState();
}

class _RouteListViewState extends State<RouteListView> {
  DateTime currentDate = DateTime.now();

  late RouteListViewBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of(context)..add(RouteListViewStartLoad(currentDate));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RouteListViewBloc, RouteListViewState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is RouteListViewLoadFail) {
          AppExceptionHandle.handle(context, state.exception);
        }
      },
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
              ),
              _buildButtonArrow(ImageUtils.icArrowPreviousDate, () {
                currentDate = currentDate.subtract(Duration(days: 1));
                bloc.add(RouteListViewStartLoad(currentDate));
              }),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextNormal(
                    align: TextAlign.center,
                    size: 16,
                    color: ColorUtils.greenHome,
                    content:
                        DateFormat("MMMM dd, yyyy - EEEE").format(currentDate),
                    fontWeight: TextNormal.BOLD,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextNormal(
                    size: 14,
                    content: state is RouteListViewLoadSuccessful
                        ? state.vm.subTitle
                        : "",
                  )
                ],
              )),
              SizedBox(
                width: 5,
              ),
              _buildButtonArrow(ImageUtils.icArrowNextDate, () {
                currentDate = currentDate.add(Duration(days: 1));
                bloc.add(RouteListViewStartLoad(currentDate));
              }),
              SizedBox(
                width: 20,
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          DividerApp(),
          Expanded(child: _buildMainWidget(state)),
        ],
      ),
    );
  }

  Widget _buildButtonArrow(String asset, Function()? onTap) => RippleInkWell(
      onTap: () => onTap?.call(),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Image.asset(
          asset,
          width: 13,
          height: 20,
        ),
      ));

  Widget _buildMainWidget(RouteListViewState state) {
    if (state is RouteListViewLoadSuccessful) {
      RouteListViewVM vm = state.vm;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderWidget(vm),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) =>
                ItemRouteListView(index: index, model: state.vm.items[index], onTap: () {
                  Navigator.pushNamed(context, Routes.orderDetail);
                },),
            itemCount: state.vm.items.length,
          ))
        ],
      );
    } else {
      return LoadingView();
    }
  }

  Widget _buildHeaderWidget(RouteListViewVM vm) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextNormal(
            size: 13,
            content: "${S.of(context).earliest_time}: ${vm.timePickUp}",
          ),
          SizedBox(
            height: 10,
          ),
          TextNormal(
            size: 13,
            content: "${S.of(context).est_total_miles}: ${vm.estTotalMiles}",
          ),
          SizedBox(
            height: 3,
          ),
          TextNormal(
            size: 13,
            content: "${S.of(context).est_total_pay}: ${vm.estTotalPay}",
          ),
        ],
      ),
    );
  }
}
