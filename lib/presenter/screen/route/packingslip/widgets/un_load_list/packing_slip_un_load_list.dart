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

import 'bloc/packing_slip_un_load_bloc.dart';
import 'bloc/packing_slip_un_load_event.dart';


class PackingSlipUnLoadList extends StatefulWidget {

  @override
  _PackingSlipLoadListState createState() => _PackingSlipLoadListState();
}

class _PackingSlipLoadListState extends State<PackingSlipUnLoadList> {

  late PackingSlipUnLoadBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of<PackingSlipUnLoadBloc>(context)..add(PackingSlipUnLoadStartLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PackingSlipUnLoadBloc, PackingSlipUnLoadState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is PackingSlipUnLoadFail) {
          AppExceptionHandle.handle(context, state.exception);
        }
      },
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PackingSlipTitle(dateTime: state is PackingSlipUnLoadLoadSuccessful ? state.vm.dateTime : "", type: PackingSlipType.unLoad,),
          Expanded(child: state is PackingSlipUnLoadLoadSuccessful ? ListView(
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
