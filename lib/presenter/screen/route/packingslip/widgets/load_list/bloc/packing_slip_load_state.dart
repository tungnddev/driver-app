import 'package:driver/data/remote/exception/app_exception.dart';
import 'package:driver/presenter/models/packing_slip_vn.dart';

class PackingSlipLoadState {

}

class PackingSlipLoadInitial extends PackingSlipLoadState {

}

class PackingSlipLoadLoadSuccessful extends PackingSlipLoadState {
  PackingSlipVM vm;
  PackingSlipLoadLoadSuccessful(this.vm);
}

class PackingSlipLoadLoading extends PackingSlipLoadState {

}

class PackingSlipLoadFail extends PackingSlipLoadState {
  AppException exception;
  PackingSlipLoadFail(this.exception);
}