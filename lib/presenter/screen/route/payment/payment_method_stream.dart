import 'dart:async';

import 'package:driver/presenter/models/payment_method_vm.dart';

class PaymentMethodStream {
  StreamController<PaymentMethodVM> _streamController = StreamController.broadcast();

  get stream => _streamController.stream;

  void close() {
    _streamController.close();
  }

  void addValue(PaymentMethodVM vm) {
    _streamController.add(vm);
  }
}