class ImageVM {
  ImageStatus status;
  String path;
  String url;

  ImageVM({this.status = ImageStatus.none, this.path = "", this.url = ""});
}

enum ImageStatus {
  success, fail, loading, none
}