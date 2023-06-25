import 'package:driver/data/remote/exception/exception_mapper.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/availability_day_vm.dart';
import 'package:driver/presenter/models/pending_confirm_vm.dart';
import 'package:driver/presenter/models/route_confirm_vm.dart';
import 'package:driver/utils/define/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'availability_event.dart';
import 'availability_state.dart';

class AvailabilityBloc extends Bloc<AvailabilityEvent, AvailabilityState> {

  static const int LIMIT = 15;
  // Repository repository;
  List<AvailabilityVM?> currentListAvailability = [];
  bool canLoadMore = false;
  BuildContext context;

  DateTime currentDateTime = DateTime.now();

  AvailabilityBloc({required this.context}) : super(AvailabilityInitial());

  @override
  Stream<AvailabilityState> mapEventToState(AvailabilityEvent event) async* {
    if (event is AvailabilityLoadList) {
      currentListAvailability = [];
      canLoadMore = true;
      yield AvailabilityLoading();
      yield* fetchAvailability(1);
    } else if (event is AvailabilityLoadMore) {
      if (!canLoadMore) return;
      int page = (currentListAvailability.length ~/ LIMIT) + 1;
      currentListAvailability.add(null);
      yield AvailabilityLoadSuccessful(
          listAvailability: currentListAvailability);
      yield* fetchAvailability(page,
          isLoadMore: true);
    } else if (event is AvailabilityRefresh) {
      currentListAvailability = [];
      canLoadMore = true;
      yield* fetchAvailability(1);
    } else if (event is AvailabilityFillCurrentSelected) {
      currentListAvailability.forEach((element) {
        if (element != null) {
          if (element.isSelecting) {
            element.isSelecting = false;
            element.note = event.note;
            element.type = event.availableType;
          }
        }
      });
      yield AvailabilityLoadSuccessful(
          listAvailability: currentListAvailability);
    }
  }

  Stream<AvailabilityState> fetchAvailability(
      int page,
      {bool isLoadMore = false}) async* {
    try {
      // ResponseAvailability responseAvailability =
      // await repository.getAvailability(LIMIT, page, currentFilterAction, currentFilterEmployee, currentFilterStartDate, currentFilterEndDate);

      // currentDateTime
      List<AvailabilityVM?> responseAvailability = [
        AvailabilityVM(AvailableType.none, "", DateTime.parse("2012-02-02"), false),
        AvailabilityVM(AvailableType.none, "", DateTime.parse("2012-02-03"), false),
        AvailabilityVM(AvailableType.none, "", DateTime.parse("2012-02-04"), false),
        AvailabilityVM(AvailableType.whole_day, "zoooo", DateTime.parse("2012-02-05"), false),
        AvailabilityVM(AvailableType.none, "", DateTime.parse("2012-02-06"), false),
      ];

      canLoadMore = responseAvailability.length >= LIMIT;
      if (isLoadMore) {
        currentListAvailability.removeLast();
        currentListAvailability.addAll(responseAvailability);
      } else {
        currentListAvailability = responseAvailability;
      }
      if (currentListAvailability.isEmpty) {
        yield AvailabilityLoadEmpty();
      } else {
        yield AvailabilityLoadSuccessful(
            listAvailability: currentListAvailability);
      }
    }  catch (error) {
      print(error);
      yield AvailabilityLoadFailed(
          error: ExceptionMapper.map(error));
    }
  }

  bool get isHaveSelected => currentListAvailability.any((element) => element?.isSelecting ?? false);
}