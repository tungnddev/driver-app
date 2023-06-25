import 'package:camera/camera.dart';
import 'package:driver/data/remote/exception/exception_handler.dart';
import 'package:driver/presenter/screen/camera/bloc/camera_bloc.dart';
import 'package:driver/presenter/screen/camera/bloc/camera_event.dart';
import 'package:driver/presenter/screen/camera/bloc/camera_state.dart';
import 'package:driver/routes/routes.dart';
import 'package:driver/utils/define/images.dart';
import 'package:driver/utils/widgets/gesture_detector.dart';
import 'package:driver/utils/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraBloc(),
      child: CameraWidget(),
    );
  }
}

class CameraWidget extends StatefulWidget {
  const CameraWidget({Key? key}) : super(key: key);

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late CameraBloc bloc;

  double currentZoomView = 1;
  double currentZoomCamera = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    bloc = BlocProvider.of<CameraBloc>(context)..add(CameraInit());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  BlocConsumer<CameraBloc, CameraState>(
                      builder: (context, state) {
                    if (state is CameraLoadSuccessful) {
                      return GestureDetector(
                        onScaleUpdate: (details) async {
                          // if (details.scale != 1) {
                          double zoom = details.scale * currentZoomCamera;
                          var cameraZoom =
                              double.parse(((zoom)).toStringAsFixed(1));
                          if (cameraZoom >= state.cameraModel.minZoom &&
                              cameraZoom <= state.cameraModel.maxZoom) {
                            print(
                                "zooom:$zoom ${state.cameraModel.maxZoom} ${state.cameraModel.minZoom}");
                            currentZoomView = details.scale;
                            await bloc.cameraController
                                .setZoomLevel(cameraZoom);
                          }
                          // }
                        },
                        onScaleEnd: (details) {
                          currentZoomCamera =
                              currentZoomCamera * currentZoomView;
                        },
                        child: Center(
                          child: state.cameraController.buildPreview(),
                        ),
                      );
                    }
                    return LoadingView();
                  }, listener: (context, state) {
                    if (state is CameraLoadFail) {
                      AppExceptionHandle.handle(context, state.exception);
                    }
                  }),
                  GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 10, right: 20, left: 15),
                        child: Image.asset(ImageUtils.imgCloseCamera, width: 19, height: 19,),
                      ),
                      onTap: () => Navigator.pop(context))
                ],
              ),
            ),
            Container(
              height: 90,
              color: Colors.black,
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(),
                  ),
                  GestureDetector(
                      child: Image.asset(
                        ImageUtils.imgCaptureImage,
                        width: 61,
                        height: 61,
                      ),
                      onTap: () async {
                        XFile xFile = await bloc.cameraController.takePicture();
                        var result  = await Navigator.pushNamed(context, Routes.cameraPreview, arguments: xFile.path);
                        if (result == true) {
                          Navigator.pop(context, xFile.path);
                        }
                      }),
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(left: 5, bottom: 5, top: 5, right: 25),
                        child: Image.asset(
                          ImageUtils.imgChangeImage,
                          width: 42,
                          height: 34,
                        ),
                      ),
                      onTap: () {
                        bloc.add(ChangeCameraDirection());
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      bloc.add(CameraInActivate());
    } else if (state == AppLifecycleState.resumed) {
      bloc.add(CameraOnResume());
    }
  }
}
