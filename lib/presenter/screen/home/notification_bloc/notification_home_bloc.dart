import 'package:driver/data/remote/exception/app_exception.dart';
import 'package:driver/data/remote/exception/exception_mapper.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/notification_home_vm.dart';
import 'package:driver/presenter/screen/home/notification_bloc/notification_home_event.dart';
import 'package:driver/presenter/screen/home/notification_bloc/notification_home_state.dart';
import 'package:driver/utils/define/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationHomeBloc extends Bloc<NotificationHomeEvent, NotificationHomeState> {

  BuildContext context;

  NotificationHomeBloc({required this.context}) : super(NotificationHomeInitial());

  @override
  Stream<NotificationHomeState> mapEventToState(NotificationHomeEvent event) async* {
    try {
      yield NotificationHomeLoading();
      await Future.delayed(Duration(milliseconds: 5000));
      List<NotificationHomeVM> list = [
        NotificationHomeVM(S.of(context).lorem, ImageUtils.icNotificationWarning),
        NotificationHomeVM(S.of(context).lorem, ImageUtils.icNotificationAdmin),
        NotificationHomeVM(S.of(context).lorem, ImageUtils.icNotificationRoute),
        NotificationHomeVM(S.of(context).lorem, ImageUtils.icNotificationSetting)
      ];
      yield NotificationHomeLoadSuccess(list: list);
    } catch (e) {
      yield NotificationHomeLoadError(appException: ExceptionMapper.map(e));
    }
  }

}