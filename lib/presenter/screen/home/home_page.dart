import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/notification_home_vm.dart';
import 'package:driver/presenter/screen/home/notification_bloc/notification_home_bloc.dart';
import 'package:driver/presenter/screen/home/notification_bloc/notification_home_event.dart';
import 'package:driver/presenter/screen/home/notification_bloc/notification_home_state.dart';
import 'package:driver/presenter/screen/home/widgets/home_header.dart';
import 'package:driver/presenter/screen/home/widgets/home_item_list.dart';
import 'package:driver/presenter/screen/home/widgets/home_notification.dart';
import 'package:driver/presenter/screen/home/widgets/home_weather.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => NotificationHomeBloc(context: context))
    ], child: HomePageWidget());
  }
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {

  late NotificationHomeBloc notificationHomeBloc;

  @override
  void initState() {
    super.initState();
    notificationHomeBloc = BlocProvider.of<NotificationHomeBloc>(context)..add(NotificationHomeLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(),
            Expanded(child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HomeItemList(),
                  Container(
                    color: ColorUtils.blueHome,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BlocBuilder<NotificationHomeBloc, NotificationHomeState>(
                              bloc: notificationHomeBloc,
                              builder: (context, state) =>
                                  HomeNotification(state: state,)),
                          SizedBox(
                            height: 16,
                          ),
                          HomeWeather()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
