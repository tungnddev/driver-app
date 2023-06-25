import 'nullable.dart';

extension ResizeImage on String? {
  String resizeUrl(int width, int height) {
    if (this.isNullOrEmpty) return "";
    int lastIndexSlash = this!.lastIndexOf("/");
    return this!.substring(0, lastIndexSlash) +
        "/" +
        width.toString() +
        "x" +
        height.toString() +
        this!.substring(lastIndexSlash);
  }
}