import 'dart:async';

class RouteTabStream {
  StreamController<int> _streamController = StreamController.broadcast();

  get stream => _streamController.stream;

  void close() {
    _streamController.close();
  }

  void addValue(int index) {
    _streamController.add(index);
  }
}