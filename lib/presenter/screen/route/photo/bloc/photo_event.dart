class PhotoEvent {

}

class PhotoUpLoad extends PhotoEvent {
  int index;
  String path;
  PhotoUpLoad(this.index, this.path);
}