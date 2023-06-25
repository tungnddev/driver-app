import 'package:driver/presenter/screen/calendar/calendar_page.dart';
import 'package:driver/presenter/screen/camera/camera_page.dart';
import 'package:driver/presenter/screen/camera/camera_preview_page.dart';
import 'package:driver/presenter/screen/home/home_page.dart';
import 'package:driver/presenter/screen/list/dummy_page.dart';
import 'package:driver/presenter/screen/login/login_page.dart';
import 'package:driver/presenter/screen/notification/notification_page.dart';
import 'package:driver/presenter/screen/profile/profile_page.dart';
import 'package:driver/presenter/screen/route/driver_payment/driver_payment_page.dart';
import 'package:driver/presenter/screen/route/orderdetail/order_detail_page.dart';
import 'package:driver/presenter/screen/route/packingslip/packing_slip_page.dart';
import 'package:driver/presenter/screen/route/payment/payment_page.dart';
import 'package:driver/presenter/screen/route/photo/photo_page.dart';
import 'package:driver/presenter/screen/route/reviewnotes/review_notes_page.dart';
import 'package:driver/presenter/screen/route/route/route_page.dart';
import 'package:driver/presenter/screen/splash/splash_page.dart';
import 'package:driver/presenter/screen/utils/photo_view.dart';
import 'package:driver/utils/widgets/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.list:
        return MaterialPageRoute<dynamic>(builder: (_) => DummyPage());
      case Routes.login:
        return MaterialPageRoute<dynamic>(builder: (_) => LoginPage());
      case Routes.home:
        return MaterialPageRoute<dynamic>(builder: (_) => HomePage());
      case Routes.profile:
        return MaterialPageRoute<dynamic>(builder: (_) => ProfilePage());
      case Routes.notification:
        return MaterialPageRoute<dynamic>(builder: (_) => NotificationPage());
      case Routes.calendar:
        return MaterialPageRoute<dynamic>(builder: (_) => CalendarPage());
      case Routes.route:
        return MaterialPageRoute<dynamic>(builder: (_) => RoutePage());
      case Routes.packingSlip:
        return MaterialPageRoute<dynamic>(builder: (_) => PackingSlipPage());
      case Routes.orderDetail:
        return MaterialPageRoute<dynamic>(builder: (_) => OrderDetailPage());
      case Routes.payment:
        return MaterialPageRoute<dynamic>(builder: (_) => PaymentPage());
      case Routes.photo:
        return MaterialPageRoute<dynamic>(builder: (_) => PhotoPage());
      case Routes.reviewNotes:
        return MaterialPageRoute<dynamic>(builder: (_) => ReviewNotesPage());
      case Routes.driverPayment:
        return MaterialPageRoute<dynamic>(builder: (_) => DriverPaymentPage());
      case Routes.camera:
        return MaterialPageRoute<dynamic>(builder: (_) => CameraPage());
      case Routes.splash:
        return MaterialPageRoute<dynamic>(builder: (_) => SplashPage());
      // case Routes.cameraPreview:
      //   return MaterialPageRoute<dynamic>(builder: (_) => CameraPreviewPage(path: args?.toString() ?? "",));
      case Routes.cameraPreview:
        return PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => CameraPreviewPage(
              path: args?.toString() ?? "",
            ));
      case Routes.photoView:
        return MaterialPageRoute<dynamic>(
            builder: (_) => PhotoViewPage(
              path: args?.toString() ?? "",
            ));
      case Routes.photoViewNoAnimation:
        return PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => PhotoViewPage(
              path: args?.toString() ?? "",
            ));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
