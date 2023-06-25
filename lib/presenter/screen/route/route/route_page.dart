import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/screen/route/route/list_view.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/app_bar.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/gesture_detector.dart';
import 'package:driver/utils/widgets/scaffold_with_color.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/route_bloc.dart';
import 'listviewbloc/list_view_bloc.dart';
import 'map_view.dart';
import 'mapviewbloc/map_view_bloc.dart';
import 'stream/route_tab_stream.dart';

class RoutePage extends StatelessWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<RouteBloc>(create: (context) => RouteBloc()),
      BlocProvider<MapViewBloc>(create: (context) => MapViewBloc(context)),
      BlocProvider<RouteListViewBloc>(create: (context) => RouteListViewBloc())
    ], child: RouteWidget());
  }
}

class RouteWidget extends StatefulWidget {
  const RouteWidget({Key? key}) : super(key: key);

  @override
  _RouteWidgetState createState() => _RouteWidgetState();
}

class _RouteWidgetState extends State<RouteWidget> {
  RouteTabStream routeTabStream = RouteTabStream();
  int currentIndexTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    routeTabStream.close();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithColor(
      color: ColorUtils.greenHome,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DriverAppBar(
                asset: ImageUtils.icAppBarRoutes,
                title: S.of(context).home_route,
                color: ColorUtils.greenHome),
            StreamBuilder<int>(
                stream: routeTabStream.stream,
                builder: (context, snapshot) {
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            _buildTab(0),
                            _buildTab(1),
                          ],
                        ),
                        Expanded(child: _buildMainWidget(snapshot.data ?? 0))
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(int index) => Expanded(
          child: RippleInkWell(
            onTap: () {
              currentIndexTab = index;
              routeTabStream.addValue(index);
            },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          color: currentIndexTab == index
              ? ColorUtils.greenSelectedTab
              : ColorUtils.greenUnSelectedTab,
          height: 46,
          alignment: Alignment.center,
          child: TextNormal(
            content:
                index == 0 ? S.of(context).map_view : S.of(context).list_view,
            color: currentIndexTab == index
                ? ColorUtils.yellowSelectedTab
                : Colors.white,
            fontWeight:
                currentIndexTab == index ? FontWeight.bold : FontWeight.normal,
            size: 17,
          ),
        ),
      ));

  Widget _buildMainWidget(int index) {
    return index == 0 ? MapView() : RouteListView();
  }
}
