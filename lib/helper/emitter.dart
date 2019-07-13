List<EmitterListener> _emitterListeners = [];

emit(String emitterName, Map<String, dynamic> args) {
  for (var emitterListener in _emitterListeners) {
    if (emitterName == emitterListener.name) {
      emitterListener.callback(args);
    }
  }
}

EmitterListener addListener(
    String emitterName, Function(Map<String, dynamic>) callback) {
  var emitterListener = EmitterListener(emitterName, callback);
  _emitterListeners.add(emitterListener);
  return emitterListener;
}

removeListener(EmitterListener emitterListener) {
  _emitterListeners.removeAt(_emitterListeners.indexOf(emitterListener));
}

class EmitterListener {
  final String name;
  final Function(Map<String, dynamic>) callback;

  EmitterListener(this.name, this.callback);
}
