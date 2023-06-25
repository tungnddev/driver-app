import 'package:driver/data/local/services/hive.dart';
import 'package:driver/data/repositories/dummy_repository.dart';
import 'package:driver/env/environment.dart';
import 'package:driver/generated/l10n.dart';
import 'package:driver/routes/route_generator.dart';
import 'package:driver/routes/routes.dart';
import 'package:driver/utils/define/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';

void mainDelegate() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // BlocSupervisor.delegate = SimpleBlocDelegate();
  await HiveService.instance.initialize();
  runApp(DriverApp());
}

class DriverApp extends StatelessWidget {
  const DriverApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => DummyRepositoryImp.instance, lazy: true,),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        onGenerateRoute: RouteGenerator.generateRoute,
        locale: Locale("en"),
        initialRoute: Routes.splash,
        theme: ThemeData(
          primaryColor: ColorUtils.blueTheme
        ),
        builder: (BuildContext context, Widget? widget) {
          if (!Environment.isDebugMode()) {
            setErrorBuilder();
          }
          return widget ?? Container();
        },
      ),
    );
  }

  void setErrorBuilder() {
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {

      // RepositoryProvider.of<SentryClient>(context).capture(
      //     event: Event(
      //         userContext: User(
      //           id: state is FetchInitialDataSuccess ? state.userID.toString() : "0",
      //           username: state is FetchInitialDataSuccess ? state.email.toString() : "",
      //         ),
      //         environment: Environment.isDebugMode() ? "debug" : "product",
      //         stackTrace: errorDetails.stack,
      //         exception: errorDetails.exception
      //     )
      // );
      return Container();
    };
  }
}