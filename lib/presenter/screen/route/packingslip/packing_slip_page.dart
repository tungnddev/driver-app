import 'package:driver/app/app.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/screen/route/packingslip/bloc/packing_slip_bloc.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/app_bar.dart';
import 'package:driver/utils/widgets/button.dart';
import 'package:driver/utils/widgets/divider.dart';
import 'package:driver/utils/widgets/scaffold_with_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/load_list/bloc/packing_slip_load_bloc.dart';
import 'widgets/load_list/packing_slip_load_list.dart';
import 'widgets/un_load_list/bloc/packing_slip_un_load_bloc.dart';
import 'widgets/un_load_list/packing_slip_un_load_list.dart';

class PackingSlipPage extends StatelessWidget {
  const PackingSlipPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => PackingSlipBloc()),
      BlocProvider(create: (context) => PackingSlipLoadBloc()),
      BlocProvider(create: (context) => PackingSlipUnLoadBloc()),
    ], child: PackingSlipWidget());
  }
}

class PackingSlipWidget extends StatefulWidget {
  const PackingSlipWidget({Key? key}) : super(key: key);

  @override
  _PackingSlipWidgetState createState() => _PackingSlipWidgetState();
}

class _PackingSlipWidgetState extends State<PackingSlipWidget> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithColor(color: ColorUtils.grayPackingSlip, child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DriverAppBar(asset: ImageUtils.icAppBarRoutes, title: S.of(context).packing_slip, color: ColorUtils.grayPackingSlip),
        Expanded(child: PackingSlipLoadList()),
        SizedBox(height: 10,),
        Expanded(child: PackingSlipUnLoadList()),
        DividerApp(),
        Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: DriverButton(
              textColor: Colors.black,
              backgroundColor: ColorUtils.grayBackButton,
              text: S.of(context).profile_back,
              onTap: () {

              },
            ))
      ],
    ),);
  }
}

