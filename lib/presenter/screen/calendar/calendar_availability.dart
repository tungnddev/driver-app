import 'package:driver/data/remote/exception/exception_handler.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/availability_day_vm.dart';
import 'package:driver/presenter/models/route_confirm_vm.dart';
import 'package:driver/presenter/screen/calendar/stream/apply_to_select_stream.dart';
import 'package:driver/presenter/screen/calendar/widgets/item_availability.dart';
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

import 'availability_bloc/availability_bloc.dart';
import 'availability_bloc/availability_event.dart';
import 'availability_bloc/availability_state.dart';
import 'widgets/header_routes.dart';
import 'widgets/item_availability_check.dart';
import 'widgets/item_pending_confirm.dart';
import 'widgets/list_date_horizontal.dart';

class CalendarAvailability extends StatefulWidget {
  const CalendarAvailability({Key? key}) : super(key: key);

  @override
  _CalendarAvailabilityState createState() => _CalendarAvailabilityState();
}

class _CalendarAvailabilityState extends State<CalendarAvailability> {
  late AvailabilityBloc bloc;
  ApplyToSelectedStream applyToSelectedStream = ApplyToSelectedStream();

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AvailabilityBloc>(context)
      ..add(AvailabilityLoadList());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    applyToSelectedStream.close();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HeaderRoute(
          color: ColorUtils.colorBlueButton,
          text: S.of(context).enter_availability,
          child: ListMonthHorizontal(
            colorSelected: ColorUtils.colorBlueButton,
            onChange: (dateTime) {
              bloc.currentDateTime = dateTime;
              bloc.add(AvailabilityRefresh());
            },
          ),
        ),
        StreamBuilder<bool>(
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!) {
              return ItemAvailabilityCheck(
                onApply: (AvailableType availableType, String note) {
                  bloc.add(AvailabilityFillCurrentSelected(availableType, note));
                  applyToSelectedStream.addValue(false);
                },
              );
            }
            return Container();
          },
          stream: applyToSelectedStream.stream,
        ),
        Expanded(
          child: BlocConsumer<AvailabilityBloc, AvailabilityState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is AvailabilityLoadFailed) {
                  AppExceptionHandle.handle(context, state.error);
                }
              },
              builder: (context, state) => _buildMainWidget(state)),
        ),
        DividerApp(),
        _buildButton()
      ],
    );
  }

  Widget _buildMainWidget(state) {
    if (state is AvailabilityLoadEmpty) {
      return NewEmptyViewRefresh(
          content: S.of(context).empty_list,
          onRefresh: () async {
            bloc.add(AvailabilityLoadList());
          });
    } else if (state is AvailabilityLoadSuccessful) {
      return ListViewLoadMoreAndRefresh<AvailabilityVM>(
        list: state.listAvailability,
        item: (AvailabilityVM item, int index) => ItemAvailability(
          model: item,
          onChangeSelected: () {
            applyToSelectedStream.addValue(bloc.isHaveSelected);
          },
        ),
        onLoadMore: () => bloc.add(AvailabilityLoadMore()),
        onRefresh: () => bloc.add(AvailabilityRefresh()),
      );
    }
    return LoadingView();
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: DriverButton(
              textColor: Colors.black,
              backgroundColor: Color(0xFFD3D3D3),
              text: S.of(context).profile_back,
              onTap: () {
                print(bloc.currentListAvailability[0]!.type.toString());
              },
            ),
            flex: 1,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: DriverButton(
              text: S.of(context).profile_save,
              onTap: () {},
            ),
            flex: 2,
          )
        ],
      ),
    );
  }
}
