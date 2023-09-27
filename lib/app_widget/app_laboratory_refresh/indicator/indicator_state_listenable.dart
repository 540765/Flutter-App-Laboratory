import 'package:flutter/foundation.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/notifier/indicator_notifier.dart';

class IndicatorStateListenable extends ValueListenable {
  ///指示器的状态通知器
  IndicatorNotifier? indicatorNotifier;

  ///存储指示器状态刷新的回调函数
  final List<VoidCallback> listeners = [];

  ///添加指示器状态刷新的回调函数
  void bind(IndicatorNotifier indicatorNotifier) {
    this.indicatorNotifier = indicatorNotifier;
    if (listeners.isNotEmpty) {
      indicatorNotifier.addListener(listeners[0]);
      Future(onNotify);
    }
  }

  void onNotify() {
    for (final listener in listeners) {
      listener();
    }
  }

  void unbind() {
    indicatorNotifier?.removeListener(onNotify);
    indicatorNotifier = null;
  }

  @override
  void addListener(VoidCallback listener) {
    if(listeners.isEmpty){
      indicatorNotifier?.addListener(onNotify);
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    listeners.remove(listener);
    if(listeners.isEmpty){
      indicatorNotifier?.removeListener(onNotify);
    }
  }

  @override
  get value => indicatorNotifier;
}
