import 'package:driver/data/remote/exception/exception_handler.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/presenter/models/packing_slip_vn.dart';
import 'package:driver/presenter/screen/route/packingslip/widgets/item_packing_slip.dart';
import 'package:driver/presenter/screen/route/packingslip/widgets/un_load_list/bloc/packing_slip_un_load_state.dart';
import 'package:driver/utils/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../packing_slip_type.dart';
import '../item_header_packing_slip.dart';
import '../item_title_packing_slip.dart';
import 'package:collection/collection.dart';

import 'bloc/packing_slip_load_bloc.dart';
import 'bloc/packing_slip_load_event.dart';
import 'bloc/packing_slip_load_state.dart';


class PackingSlipLoadList extends StatefulWidget {
  @override
  _PackingSlipLoadListState createState() => _PackingSlipLoadListState();
}

class _PackingSlipLoadListState extends State<PackingSlipLoadList> {

  late PackingSlipLoadBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of<PackingSlipLoadBloc>(context)..add(PackingSlipLoadStartLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PackingSlipLoadBloc, PackingSlipLoadState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is PackingSlipLoadFail) {
            AppExceptionHandle.handle(context, state.exception);
          }
        },
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PackingSlipTitle(dateTime: state is PackingSlipLoadLoadSuccessful ? state.vm.dateTime : "", type: PackingSlipType.load,),
            Expanded(child: state is PackingSlipLoadLoadSuccessful ? ListView(
              children: [
                PackingSlipHeader(text1: S.of(context).invoice, text2: S.of(context).order_items, text3: S.of(context).quantity),
                ...state.vm.orders.mapIndexed((index, element) => PackingSlipItem(index: index, model: element, )),
                PackingSlipHeader(text1: "", text2: S.of(context).accessories, text3: S.of(context).quantity),
                ...state.vm.accessories.mapIndexed((index, element) => PackingSlipItem(index: index, model: element, )),
              ],
            ) : LoadingView(size: 20, strokeWidth: 2,),
            )
          ],
        )
    );
  }
}
