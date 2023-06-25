import 'package:driver/presenter/models/login_infor_vm.dart';
import 'package:driver/presenter/screen/login/bloc/login_event.dart';
import 'package:driver/presenter/screen/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  LoginInfoVM loginVM = LoginInfoVM.init();


  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginStartLogin) {
      if (!loginVM.isValid) return;
      yield LoginLoading();
      await Future.delayed(Duration(seconds: 1));
      yield LoginSuccessful();
    }
  }
}