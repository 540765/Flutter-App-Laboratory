import 'package:flutter/foundation.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/notifier/indicator_notifier.dart';

class IndicatorListenable<T extends IndicatorNotifier>
    extends ValueListenable<T> {
  final T _indicatorNotifier;
  IndicatorListenable(this._indicatorNotifier);

  final List<VoidCallback> _listeners = [];

  void _onNotify() {
    for (final listener in _listeners) {
      listener();
    }
  }

  @override
  void addListener(VoidCallback listener) {
    if (_listeners.isEmpty) {
      _indicatorNotifier.addListener(_onNotify);
    }
    _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    debugPrint('removeListener');
    _listeners.remove(listener);
    if (_listeners.isEmpty) {
      _indicatorNotifier.removeListener(_onNotify);
    }
  }

  @override
  T get value => _indicatorNotifier;
}
