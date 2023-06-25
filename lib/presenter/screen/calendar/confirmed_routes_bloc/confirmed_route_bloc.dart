import 'package:driver/data/remote/exception/exception_mapper.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/route_confirm_vm.dart';
import 'package:driver/utils/define/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'confirmed_route_event.dart';
import 'confirmed_route_state.dart';

class ConfirmedRouteBloc extends Bloc<ConfirmedRouteEvent, ConfirmedRouteState> {

  static const int LIMIT = 15;
  // Repository repository;
  List<RouteConfirmVM?> currentListConfirmedRoute = [];
  bool canLoadMore = false;
  BuildContext context;

  DateTime currentDateTime = DateTime.now();

  ConfirmedRouteBloc({required this.context}) : super(ConfirmedRouteInitial());

  @override
  Stream<ConfirmedRouteState> mapEventToState(ConfirmedRouteEvent event) async* {
    if (event is ConfirmedRouteLoadList) {
      currentListConfirmedRoute = [];
      canLoadMore = true;
      yield ConfirmedRouteLoading();
      yield* fetchConfirmedRoute(1);
    } else if (event is ConfirmedRouteLoadMore) {
      if (!canLoadMore) return;
      int page = (currentListConfirmedRoute.length ~/ LIMIT) + 1;
      currentListConfirmedRoute.add(null);
      yield ConfirmedRouteLoadSuccessful(
          listConfirmedRoute: currentListConfirmedRoute);
      yield* fetchConfirmedRoute(page,
          isLoadMore: true);
    } else if (event is ConfirmedRouteRefresh) {
      currentListConfirmedRoute = [];
      canLoadMore = true;
      yield* fetchConfirmedRoute(1);
    }
  }

  Stream<ConfirmedRouteState> fetchConfirmedRoute(
      int page,
      {bool isLoadMore = false}) async* {
    try {
      // ResponseConfirmedRoute responseConfirmedRoute =
      // await repository.getConfirmedRoute(LIMIT, page, currentFilterAction, currentFilterEmployee, currentFilterStartDate, currentFilterEndDate);

      // currentDateTime
      List<RouteConfirmVM?> responseConfirmedRoute = [
        RouteConfirmVM("3091023", "Mary Poppins", "98737172733", "54442 Branford St.Pacoime CA 0911", DateTime.parse("2021-07-23 13:27:00")),
        RouteConfirmVM("3091024", "Mary Poppins Insalold", "98737172733", "54442 Branford St.Pacoime CA 0911", DateTime.parse("2021-07-23 13:27:00")),
        RouteConfirmVM("3091026", "Mary Poppins Oyote", "98737172733", "54442 Branford St.Pacoime CA 0911", DateTime.parse("2021-07-23 13:27:00")),
        RouteConfirmVM("3091026", "Osas", "98737172733", "54442 Branford St.Pacoime CA 0911", DateTime.parse("2021-07-23 13:27:00")),
        RouteConfirmVM("3091027", "Mary Potter", "98737172733", "54442 Branford St.Pacoime CA 0911", DateTime.parse("2021-07-23 13:27:00")),
        RouteConfirmVM("3091028", "Mary Poppins", "98737172733", "54442 Branford St.Pacoime CA 0911", DateTime.parse("2021-07-23 13:27:00")),
      ];

      canLoadMore = responseConfirmedRoute.length >= LIMIT;
      if (isLoadMore) {
        currentListConfirmedRoute.removeLast();
        currentListConfirmedRoute.addAll(responseConfirmedRoute);
      } else {
        currentListConfirmedRoute = responseConfirmedRoute;
      }
      if (currentListConfirmedRoute.isEmpty) {
        yield ConfirmedRouteLoadEmpty();
      } else {
        yield ConfirmedRouteLoadSuccessful(
            listConfirmedRoute: currentListConfirmedRoute);
      }
    } on Exception catch (error) {
      yield ConfirmedRouteLoadFailed(
          error: ExceptionMapper.map(error));
    }
  }

}