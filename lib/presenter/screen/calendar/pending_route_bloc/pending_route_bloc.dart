import 'package:driver/data/remote/exception/exception_mapper.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/pending_confirm_vm.dart';
import 'package:driver/presenter/models/route_confirm_vm.dart';
import 'package:driver/utils/define/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pending_route_event.dart';
import 'pending_route_state.dart';

class PendingRouteBloc extends Bloc<PendingRouteEvent, PendingRouteState> {

  static const int LIMIT = 15;
  // Repository repository;
  List<PendingConfirmVM?> currentListPendingRoute = [];
  bool canLoadMore = false;
  BuildContext context;

  DateTime currentDateTime = DateTime.now();

  PendingRouteBloc({required this.context}) : super(PendingRouteInitial());

  @override
  Stream<PendingRouteState> mapEventToState(PendingRouteEvent event) async* {
    if (event is PendingRouteLoadList) {
      currentListPendingRoute = [];
      canLoadMore = true;
      yield PendingRouteLoading();
      yield* fetchPendingRoute(1);
    } else if (event is PendingRouteLoadMore) {
      if (!canLoadMore) return;
      int page = (currentListPendingRoute.length ~/ LIMIT) + 1;
      currentListPendingRoute.add(null);
      yield PendingRouteLoadSuccessful(
          listPendingRoute: currentListPendingRoute);
      yield* fetchPendingRoute(page,
          isLoadMore: true);
    } else if (event is PendingRouteRefresh) {
      currentListPendingRoute = [];
      canLoadMore = true;
      yield* fetchPendingRoute(1);
    }
  }

  Stream<PendingRouteState> fetchPendingRoute(
      int page,
      {bool isLoadMore = false}) async* {
    try {
      // ResponsePendingRoute responsePendingRoute =
      // await repository.getPendingRoute(LIMIT, page, currentFilterAction, currentFilterEmployee, currentFilterStartDate, currentFilterEndDate);

      // currentDateTime
      List<PendingConfirmVM?> responsePendingRoute = [
        PendingConfirmVM("San Fernando Valley", "5 Inflatables, tables, chairs", "\$200", "150miles"),
        PendingConfirmVM("San Fernando Valley", "5 Inflatables, tables, chairs", "\$200", "150miles"),
        PendingConfirmVM("San Fernando Valley", "5 Inflatables, tables, chairs", "\$200", "150miles"),
        PendingConfirmVM("San Fernando Valley", "5 Inflatables, tables, chairs", "\$200", "150miles"),
        PendingConfirmVM("San Fernando Valley", "5 Inflatables, tables, chairs", "\$200", "150miles"),
        PendingConfirmVM("San Fernando Valley", "5 Inflatables, tables, chairs", "\$200", "150miles"),
        PendingConfirmVM("San Fernando Valley", "5 Inflatables, tables, chairs", "\$200", "150miles"),
        PendingConfirmVM("San Fernando Valley", "5 Inflatables, tables, chairs", "\$200", "150miles"),
        PendingConfirmVM("San Fernando Valley", "5 Inflatables, tables, chairs", "\$200", "150miles"),
        PendingConfirmVM("San Fernando Valley", "5 Inflatables, tables, chairs", "\$200", "150miles"),
        PendingConfirmVM("San Fernando Valley", "5 Inflatables, tables, chairs", "\$200", "150miles"),
        PendingConfirmVM("San Fernando Valley", "5 Inflatables, tables, chairs", "\$200", "150miles"),
        PendingConfirmVM("San Fernando Valley", "5 Inflatables, tables, chairs", "\$200", "150miles"),
      ];

      canLoadMore = responsePendingRoute.length >= LIMIT;
      if (isLoadMore) {
        currentListPendingRoute.removeLast();
        currentListPendingRoute.addAll(responsePendingRoute);
      } else {
        currentListPendingRoute = responsePendingRoute;
      }
      if (currentListPendingRoute.isEmpty) {
        yield PendingRouteLoadEmpty();
      } else {
        yield PendingRouteLoadSuccessful(
            listPendingRoute: currentListPendingRoute);
      }
    } on Exception catch (error) {
      yield PendingRouteLoadFailed(
          error: ExceptionMapper.map(error));
    }
  }

}