import 'package:driver/presenter/models/packing_slip_vn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'packing_slip_load_event.dart';
import 'packing_slip_load_state.dart';

class PackingSlipLoadBloc
    extends Bloc<PackingSlipLoadEvent, PackingSlipLoadState> {
  PackingSlipLoadBloc() : super(PackingSlipLoadInitial());

  @override
  Stream<PackingSlipLoadState> mapEventToState(
      PackingSlipLoadEvent event) async* {
    if (event is PackingSlipLoadStartLoad) {
      yield PackingSlipLoadLoading();
      PackingSlipVM vm = PackingSlipVM([
        PackingSlipItemVM("301201", "Race Car", "1", false),
        PackingSlipItemVM("300383", "Enchanted Castle Combo", "1", false),
        PackingSlipItemVM("301196", "Fun House 10X10", "1", false),
        PackingSlipItemVM("300383", "Princess Castle 10X10", "1", false),
      ], [
        PackingSlipItemVM("", "1-HP Blower", "2", true),
        PackingSlipItemVM("", "Stakes", "8", true)
      ], "January 22, 2021 - Friday");
      await Future.delayed(Duration(seconds: 1));
      yield PackingSlipLoadLoadSuccessful(vm);
    }
  }
}
