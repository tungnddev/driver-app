import 'package:camera/camera.dart';
import 'package:driver/data/remote/exception/exception_mapper.dart';
import 'package:driver/presenter/screen/camera/bloc/camera_event.dart';
import 'package:driver/presenter/screen/camera/bloc/camera_state.dart';
import 'package:driver/presenter/screen/camera/camera_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraStateLoading());

  List<CameraDescription> currentListCamera = [];
  int currentSelectedCamera = 0;
  late CameraController cameraController;

  @override
  Stream<CameraState> mapEventToState(CameraEvent event) async* {
    if (event is CameraInit) {
      yield CameraStateLoading();
      currentListCamera = await availableCameras();
      yield* initNewCamera();
    } else if (event is ChangeCameraDirection) {
      if (currentListCamera.isEmpty) return;
      yield CameraStateLoading();
      if (currentSelectedCamera >= currentListCamera.length - 1) {
        currentSelectedCamera = 0;
      } else {
        currentSelectedCamera++;
      }
      await cameraController.dispose();
      yield* initNewCamera(isLoading: false);
    } else if (event is CameraInActivate) {
      await cameraController.dispose();
    } else if (event is CameraOnResume) {
      yield* initNewCamera();
    } else if (event is CameraZoom) {


    }
  }

  Stream<CameraState> initNewCamera({isLoading = true}) async* {
    if (currentListCamera.isNotEmpty) {
      if (isLoading)  {
        yield CameraStateLoading();
      }
      cameraController = CameraController(currentListCamera[currentSelectedCamera], ResolutionPreset.ultraHigh, imageFormatGroup: ImageFormatGroup.jpeg, );
      await cameraController.initialize();
      double minZoom = await cameraController.getMinZoomLevel();
      double maxZoom = await cameraController.getMaxZoomLevel();
      await cameraController.setFlashMode(FlashMode.off);
      yield CameraLoadSuccessful(cameraController, CameraModel(maxZoom: maxZoom, minZoom: minZoom));
    } else {
      yield CameraLoadFail(ExceptionMapper.map("Err"));
    }
  }

  @override
  Future<void> close() {
    cameraController.dispose();
    return super.close();
  }

}