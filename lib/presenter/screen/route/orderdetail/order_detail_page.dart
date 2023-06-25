import 'package:driver/app/app.dart';
import 'package:driver/data/remote/exception/exception_handler.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/order_detail_vm.dart';
import 'package:driver/presenter/screen/route/orderdetail/bloc/order_detail_bloc.dart';
import 'package:driver/presenter/screen/route/orderdetail/bloc/order_detail_state.dart';
import 'package:driver/presenter/screen/route/orderdetail/widgets/order_detail_info.dart';
import 'package:driver/presenter/screen/route/orderdetail/widgets/order_detail_instruction.dart';
import 'package:driver/presenter/screen/route/orderdetail/widgets/order_detail_items.dart';
import 'package:driver/presenter/screen/route/orderdetail/widgets/order_detail_price.dart';
import 'package:driver/presenter/screen/route/orderdetail/widgets/order_detail_title.dart';
import 'package:driver/presenter/screen/route/orderdetail/widgets/order_detail_transactions.dart';
import 'package:driver/routes/routes.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/app_bar.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/button_with_arrow.dart';
import 'package:driver/utils/widgets/loading_view.dart';
import 'package:driver/utils/widgets/scaffold_with_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/order_detail_event.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => OrderDetailBloc(context: context))
    ], child: OrderDetailWidget());
  }
}

class OrderDetailWidget extends StatefulWidget {
  const OrderDetailWidget({Key? key}) : super(key: key);

  @override
  _OrderDetailWidgetState createState() => _OrderDetailWidgetState();
}

class _OrderDetailWidgetState extends State<OrderDetailWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<OrderDetailBloc>(context).add(OrderDetailStartLoad(0));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithColor(
        color: ColorUtils.grayPackingSlip,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DriverAppBar(
                asset: ImageUtils.icAppbarOrderDetail,
                title: S.of(context).order_details,
                color: ColorUtils.grayPackingSlip),
            BlocConsumer<OrderDetailBloc, OrderDetailState>(
                builder: (context, state) => Expanded(
                    child: state is OrderDetailLoadSuccess
                        ? _buildMainWidget(state.vm)
                        : LoadingView()),
                listener: (context, state) {
                  if (state is OrderDetailLoadFail) {
                    AppExceptionHandle.handle(context, state.exception);
                  }
                })
          ],
        ));
  }

  Widget _buildMainWidget(OrderDetailVM vm) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
          Expanded(
            child: ListView(
              children: [
                OrderDetailTitle(vm: vm),
                OrderDetailInfo(vm: vm),
                OrderDetailItems(vm: vm),
                OrderDetailTransactions(vm: vm.orderTransition),
                OrderDetailSpecialInstruction(instructions: vm.specialInstructions),
                OrderDetailPrice(fee: vm.fee),
              ],
            ),
          ),
      _buildButton()
        ],
  );

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Expanded(child: DriverButton(textColor: Colors.black, backgroundColor: Color(0xFFD3D3D3), text: S.of(context).profile_back, onTap: () {

          },), flex: 1,),
          SizedBox(width: 18,),
          Expanded(child: DriverButtonWithArrow(text: S.of(context).proceed_to_payment_method, onTap: () {
            Navigator.pushNamed(context, Routes.payment);
          },), flex: 2,)
        ],
      ),
    );
  }
}
