class CameraEvent {

}

class CameraInit extends CameraEvent {

}

class ChangeCameraDirection extends CameraEvent {

}

class CameraInActivate extends CameraEvent {

}

class CameraOnResume extends CameraEvent {

}

class CameraZoom extends CameraEvent {
  double zoom;
  CameraZoom(this.zoom);
}