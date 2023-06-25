import 'package:driver/data/remote/exception/app_exception.dart';
import 'package:driver/presenter/models/order_detail_vm.dart';

class OrderDetailState {
}

class OrderDetailLoading extends OrderDetailState{

}

class OrderDetailLoadSuccess extends OrderDetailState {
  OrderDetailVM vm;
  OrderDetailLoadSuccess(this.vm);
}

class OrderDetailLoadFail extends OrderDetailState {
  AppException exception;
  OrderDetailLoadFail(this.exception);
}