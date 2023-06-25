import 'package:driver/presenter/screen/splash/bloc/splash_bloc.dart';
import 'package:driver/presenter/screen/splash/bloc/splash_event.dart';
import 'package:driver/presenter/screen/splash/bloc/splash_state.dart';
import 'package:driver/routes/routes.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:driver/utils/define/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => SplashBloc())],
        child: SplashWidget());
  }
}

class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  late SplashBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of<SplashBloc>(context)..add(SplashStartInit());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashOpenLogin) {
            Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (route) => false);
          } if (state is SplashOpenHome) {
            Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (route) => false);
          }
        },
        bloc: bloc,
        builder: (context, state) => Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          color: ColorUtils.colorLogin,
          child: Image.asset(
            ImageUtils.imgLogoLogin,
            width: 300,
            height: 174,
          ),
        ),
      ),
    );
  }
}
