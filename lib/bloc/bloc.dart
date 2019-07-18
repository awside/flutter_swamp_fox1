import 'dart:async';

class Bloc<State, Event> {
  final _stateController = StreamController<State>.broadcast();
  StreamSink<State> get _stateSink => _stateController.sink;
  Stream<State> get stream => _stateController.stream;

  final _eventController = StreamController<Event>();
  StreamSink<Event> get sink => _eventController.sink;
  Stream<Event> get _eventStream => _eventController.stream;

  Bloc() {
    _eventStream.listen((event) {
      _stateSink.add(processEvent(event));
    });
  }

  State processEvent(Event event) => null;

  dispose() {
    _stateController.close();
    _eventController.close();
  }
}
