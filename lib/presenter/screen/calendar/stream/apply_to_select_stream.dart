import 'dart:async';

class ApplyToSelectedStream {
  StreamController _streamController = StreamController<bool>();

  get stream => _streamController.stream;

  void close() {
    _streamController.close();
  }

  void addValue(bool visible) {
    _streamController.add(visible);
  }
}