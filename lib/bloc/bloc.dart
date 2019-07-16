import 'dart:async';

class Bloc {
  final _stateController = StreamController.broadcast();
  StreamSink get _stateSink => _stateController.sink;
  Stream get stream => _stateController.stream;

  final _eventController = StreamController();
  StreamSink get sink => _eventController.sink;
  Stream get _eventStream => _eventController.stream;

  Bloc() {
    _eventStream.listen((input) => _stateSink.add(input));
  }

  dispose() {
    _stateController.close();
    _eventController.close();
  }
}
