import 'package:driver/presenter/screen/splash/bloc/splash_event.dart';
import 'package:driver/presenter/screen/splash/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial());

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is SplashStartInit) {
      // await Future.delayed(Duration(seconds: 2));
      yield SplashOpenLogin();
      // yield SplashOpenHome();
    }
  }

}