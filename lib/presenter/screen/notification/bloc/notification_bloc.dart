import 'package:driver/data/remote/exception/exception_mapper.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/notification_vm.dart';
import 'package:driver/presenter/screen/notification/bloc/notification_event.dart';
import 'package:driver/presenter/screen/notification/bloc/notification_state.dart';
import 'package:driver/utils/define/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {

  static const int LIMIT = 15;
  // Repository repository;
  List<NotificationVM?> currentListNotification = [];
  bool canLoadMore = false;
  BuildContext context;

  NotificationBloc({required this.context}) : super(NotificationInitial());

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is NotificationLoadList) {
      currentListNotification = [];
      canLoadMore = true;
      yield NotificationLoading();
      yield* fetchNotification(1);
    } else if (event is NotificationLoadMore) {
      if (!canLoadMore) return;
      int page = (currentListNotification.length ~/ LIMIT) + 1;
      currentListNotification.add(null);
      yield NotificationLoadSuccessful(
          listNotification: currentListNotification);
      yield* fetchNotification(page,
          isLoadMore: true);
    } else if (event is NotificationRefresh) {
      currentListNotification = [];
      canLoadMore = true;
      yield* fetchNotification(1);
    }
  }

  Stream<NotificationState> fetchNotification(
      int page,
      {bool isLoadMore = false}) async* {
    try {
      // ResponseNotification responseNotification =
      // await repository.getNotification(LIMIT, page, currentFilterAction, currentFilterEmployee, currentFilterStartDate, currentFilterEndDate);

      List<NotificationVM?> responseNotification = [
        NotificationVM(S.of(context).lorem, ImageUtils.icNotificationAdmin),
        NotificationVM(S.of(context).lorem, ImageUtils.icNotificationRoute),
        NotificationVM(S.of(context).lorem, ImageUtils.icNotificationSetting),
        NotificationVM(S.of(context).lorem, ImageUtils.icNotificationWarning),
        NotificationVM(S.of(context).lorem, ImageUtils.icNotificationAdmin),
        NotificationVM(S.of(context).lorem, ImageUtils.icNotificationRoute),
        NotificationVM(S.of(context).lorem, ImageUtils.icNotificationSetting),
        NotificationVM(S.of(context).lorem, ImageUtils.icNotificationWarning),
        NotificationVM(S.of(context).lorem, ImageUtils.icNotificationSetting),
        NotificationVM(S.of(context).lorem, ImageUtils.icNotificationRoute),
        NotificationVM(S.of(context).lorem, ImageUtils.icNotificationWarning),
        NotificationVM(S.of(context).lorem, ImageUtils.icNotificationAdmin)
      ];

      canLoadMore = responseNotification.length >= LIMIT;
      if (isLoadMore) {
        currentListNotification.removeLast();
        currentListNotification.addAll(responseNotification);
      } else {
        currentListNotification = responseNotification;
      }
      if (currentListNotification.isEmpty) {
        yield NotificationLoadEmpty();
      } else {
        yield NotificationLoadSuccessful(
            listNotification: currentListNotification);
      }
    } on Exception catch (error) {
      yield NotificationLoadFailed(
          error: ExceptionMapper.map(error));
    }
  }

}