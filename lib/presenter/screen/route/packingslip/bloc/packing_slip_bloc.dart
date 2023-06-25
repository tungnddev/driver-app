import 'package:flutter_bloc/flutter_bloc.dart';

import 'packing_slip_event.dart';
import 'packing_slip_state.dart';


class PackingSlipBloc extends Bloc<PackingSlipEvent, PackingSlipState> {
  PackingSlipBloc() : super(PackingSlipInitial());

  @override
  Stream<PackingSlipState> mapEventToState(PackingSlipEvent event) async* {
    if (event is PackingSlipStartLoad) {

    }
  }

}