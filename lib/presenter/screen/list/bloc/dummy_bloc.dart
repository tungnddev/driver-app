import 'package:driver/domain/repositories/dummy_repository.dart';
import 'package:driver/presenter/models/dummy_vm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dummy_event.dart';
import 'dummy_state.dart';

class DummyBloc extends Bloc<DummyEvent, DummyState> {

  DummyRepository repository;

  DummyBloc({required this.repository}) : super(DummyInitial());

  @override
  Stream<DummyState> mapEventToState(DummyEvent event) async* {
    List<DummyVM> list = (await repository.fetchListDummy()).map((e) => DummyVM(dummyVm: e.dummy)).toList();
  }

}