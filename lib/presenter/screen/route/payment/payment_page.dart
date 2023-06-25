import 'package:driver/app/app.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/payment_method_vm.dart';
import 'package:driver/presenter/screen/route/payment/payment_method_stream.dart';
import 'package:driver/routes/routes.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/app_bar.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/button_with_arrow.dart';
import 'package:driver/utils/widgets/input_constraint.dart';
import 'package:driver/utils/widgets/scaffold_with_color.dart';
import 'package:driver/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaymentWidget();
  }
}

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({Key? key}) : super(key: key);

  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  PaymentMethodVM? currentPaymentMethod;
  PaymentMethodStream paymentMethodStream = PaymentMethodStream();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    paymentMethodStream.close();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithColor(
        color: ColorUtils.grayPackingSlip,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DriverAppBar(
                asset: ImageUtils.icAppBarPayment,
                title: S.of(context).payment,
                color: ColorUtils.grayPackingSlip),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: StreamBuilder<PaymentMethodVM>(
                        stream: paymentMethodStream.stream,
                        builder: (context, snapshot) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildItemPaymentMethod(PaymentMethodVM.cash),
                              _buildItemPaymentMethod(
                                  PaymentMethodVM.creditCard),
                              _buildItemPaymentMethod(PaymentMethodVM.check),
                              _buildItemPaymentMethod(
                                  PaymentMethodVM.purchaseOrder),
                            ],
                          );
                        }),
                  ),
                  TextNormal(
                    content: S.of(context).write_any_note,
                    size: 16,
                    color: Color(0xFF6A6A6A),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27),
                    child: InputConstraint(
                      onChange: (text) {},
                      hint: S.of(context).example_hint_note,
                      height: 230,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )),
            _buildButton()
          ],
        ));
  }

  Widget _buildItemPaymentMethod(PaymentMethodVM vm) {
    bool isSelected = vm == currentPaymentMethod;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () {
          currentPaymentMethod = vm;
          paymentMethodStream.addValue(vm);
        },
        child: PhysicalModel(
          color: Colors.black,
          elevation: isSelected ? 2 : 0,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 188,
            padding: EdgeInsets.symmetric(vertical: 13),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: isSelected
                        ? ColorUtils.greenHome
                        : ColorUtils.borderTabCalendar,
                    width: 1),
                color: isSelected ? ColorUtils.greenHome : Colors.white),
            alignment: Alignment.center,
            child: TextNormal(
              size: 13,
              content: vm.toStringDisplay(context),
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: DriverButton(
              textColor: Colors.black,
              backgroundColor: Color(0xFFD3D3D3),
              text: S.of(context).profile_back,
              onTap: () {},
            ),
            flex: 1,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: DriverButtonWithArrow(
              text: S.of(context).take_photos_of_setup,
              onTap: () {
                Navigator.pushNamed(context, Routes.photo);
              },
            ),
            flex: 2,
          )
        ],
      ),
    );
  }
}
