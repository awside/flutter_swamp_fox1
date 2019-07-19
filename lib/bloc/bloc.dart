import 'dart:async';

class Bloc<T> {
  T eventStateObj;

  final _streamController = StreamController<T>();
  StreamSink<T> get _sink => _streamController.sink;
  Stream<T> get stream => _streamController.stream;

  sink() => _sink.add(eventStateObj);

  close() {
    _streamController.close();
  }
}
