import 'package:driver/data/remote/exception/exception_mapper.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/order_detail_vm.dart';
import 'package:driver/presenter/screen/route/orderdetail/bloc/order_detail_event.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {

  BuildContext context;

  OrderDetailBloc({required this.context}) : super(OrderDetailLoading());

  @override
  Stream<OrderDetailState> mapEventToState(OrderDetailEvent event) async* {
    if (event is OrderDetailStartLoad) {
      try {
        yield OrderDetailLoading();
        await Future.delayed(Duration(milliseconds: 200));
        OrderDetailVM vm = OrderDetailVM(
            "Drop-Off Order #301201",
            "Activate",
            ColorUtils.blueDropOff,
            ColorUtils.greenHome,
            Colors.white,
            "Mary Poppins",
            "(818) 123 4567",
            "54331 Branford St, Pacoima CA 91331",
            "Friday, January 22, 2021 9:00am",
            "Friday, January 22, 2021 4:00pm",
            "9:00am - 12:00pm",
            "5:00pm - 8:00pm",
            "Hours?",
            [
              OrderDetailItemVM(
                "60' Boot Camp Obstacle Course",
                  "- Setup Surface: Grass\n- Insurance Certificate: Not Required\n- Overnight Option (pickup nextmorning): No \n- Any Stairs to Setup? : None \n- Damage Waiver: Yes",
                  "1",
                  "399.00",
                  "399.00")
            ],
            [
              OrderLineFeeVM(S.of(context).subtotal, "\$399.00"),
              OrderLineFeeVM(S.of(context).service_cost, "\$10.00"),
              OrderLineFeeVM(S.of(context).additional_fees, "\$10.00"),
              OrderLineFeeVM(S.of(context).tax, "\$0.00"),
              OrderLineFeeVM(S.of(context).gratuity, "\$25.00"),
              OrderLineFeeVM(S.of(context).order_total, "\$384.00"),
              OrderLineFeeVM(S.of(context).payments_received, "\$38.40"),
              OrderLineFeeVM(S.of(context).balance_due, "\$345.60", isBold: true),
            ],
            OrderTransitionVM(
                "01/20/2021 3:13pm", "\$38.40", "Credit Card 4675"));
        yield OrderDetailLoadSuccess(vm);
      } catch (e) {
        yield OrderDetailLoadFail(ExceptionMapper.map(e));
      }
    }
  }
}
