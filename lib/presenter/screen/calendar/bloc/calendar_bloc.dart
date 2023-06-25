import 'package:driver/presenter/screen/calendar/bloc/calendar_event.dart';
import 'package:driver/presenter/screen/calendar/bloc/calendar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitial());

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) async* {
    if (event is CalendarStartFill) {
      yield CalendarFill(index: event.currentIndex);
    }
  }

}