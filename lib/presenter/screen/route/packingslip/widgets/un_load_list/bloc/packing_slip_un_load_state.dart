import 'package:driver/data/remote/exception/app_exception.dart';
import 'package:driver/presenter/models/packing_slip_vn.dart';

class PackingSlipUnLoadState {

}

class PackingSlipUnLoadInitial extends PackingSlipUnLoadState {

}

class PackingSlipUnLoadLoadSuccessful extends PackingSlipUnLoadState {
  PackingSlipVM vm;
  PackingSlipUnLoadLoadSuccessful(this.vm);
}

class PackingSlipUnLoadLoading extends PackingSlipUnLoadState {

}

class PackingSlipUnLoadFail extends PackingSlipUnLoadState {
  AppException exception;
  PackingSlipUnLoadFail(this.exception);
}