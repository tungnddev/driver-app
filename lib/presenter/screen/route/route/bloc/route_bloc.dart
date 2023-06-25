import 'package:flutter_bloc/flutter_bloc.dart';

import 'route_event.dart';
import 'route_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  RouteBloc() : super(RouteInitial());

  @override
  Stream<RouteState> mapEventToState(RouteEvent event) async* {
  }

}