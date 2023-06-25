import 'package:driver/data/remote/exception/exception_mapper.dart';
import 'package:driver/presenter/models/packing_slip_vn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'packing_slip_un_load_event.dart';
import 'packing_slip_un_load_state.dart';

class PackingSlipUnLoadBloc
    extends Bloc<PackingSlipUnLoadEvent, PackingSlipUnLoadState> {
  PackingSlipUnLoadBloc() : super(PackingSlipUnLoadInitial());

  @override
  Stream<PackingSlipUnLoadState> mapEventToState(
      PackingSlipUnLoadEvent event) async* {
    if (event is PackingSlipUnLoadStartLoad) {
      try {
        yield PackingSlipUnLoadLoading();
        PackingSlipVM vm = PackingSlipVM([
          PackingSlipItemVM("301196", "Fun House 10X10", "1", false),
          PackingSlipItemVM("300753", "Princess Castle 10X10", "1", false),
        ], [
          PackingSlipItemVM("", "1-HP Blower", "2", true),
          PackingSlipItemVM("", "Stakes", "8", true)
        ], "January 22, 2021 - Friday");
        await Future.delayed(Duration(milliseconds: 500));
        yield PackingSlipUnLoadLoadSuccessful(vm);
      } catch (e) {
        yield PackingSlipUnLoadFail(ExceptionMapper.map(e));
      }
    }
  }
}
