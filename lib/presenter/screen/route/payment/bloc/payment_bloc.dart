import 'package:driver/presenter/screen/route/payment/bloc/payment_event.dart';
import 'package:driver/presenter/screen/route/payment/bloc/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial());

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
  }

}