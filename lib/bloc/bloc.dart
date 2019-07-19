import 'dart:async';

class Bloc<EventState> {
  final _eventController = StreamController<EventState>();
  StreamSink<EventState> get sink => _eventController.sink;
  Stream<EventState> get _eventStream => _eventController.stream;

  final _stateController = StreamController<EventState>();
  StreamSink<EventState> get _stateSink => _stateController.sink;
  Stream<EventState> get stream => _stateController.stream;

  Bloc() {
    _eventStream.listen((event) {
      _stateSink.add(processEvent(event));
    });
  }

  EventState processEvent(EventState event) => event;

  dispose() {
    _stateController.close();
    _eventController.close();
  }
}
