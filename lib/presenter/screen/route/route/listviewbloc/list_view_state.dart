import 'package:driver/data/remote/exception/app_exception.dart';
import 'package:driver/presenter/models/route_list_view_vm.dart';

class RouteListViewState {

}

class RouteListViewLoading extends RouteListViewState {

}

class RouteListViewLoadSuccessful extends RouteListViewState {
  RouteListViewVM vm;
  RouteListViewLoadSuccessful(this.vm);
}

class RouteListViewLoadFail extends RouteListViewState {
  AppException exception;
  RouteListViewLoadFail(this.exception);
}