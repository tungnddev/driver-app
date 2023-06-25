import 'package:camera/camera.dart';
import 'package:driver/data/remote/exception/app_exception.dart';
import 'package:driver/presenter/screen/camera/camera_model.dart';

class CameraState {

}

class CameraStateLoading extends CameraState {

}

class CameraLoadSuccessful extends CameraState {
  CameraController cameraController;
  CameraModel cameraModel;
  CameraLoadSuccessful(this.cameraController, this.cameraModel);
}

class CameraLoadFail extends CameraState {
  AppException exception;
  CameraLoadFail(this.exception);
}