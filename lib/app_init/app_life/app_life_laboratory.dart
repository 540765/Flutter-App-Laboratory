import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class AppLifeLaboratory extends StatefulWidget {
  const AppLifeLaboratory({super.key, required this.child});
  final Widget child;
  @override
  State<AppLifeLaboratory> createState() => _AppLifeLaboratoryState();
}

class _AppLifeLaboratoryState extends State<AppLifeLaboratory> {
  late final AppLifecycleListener _listener;
  // ignore: unused_field
  late AppLifecycleState? _state;

  @override
  void initState() {
    super.initState();
    _state = SchedulerBinding.instance.lifecycleState;
    _listener = AppLifecycleListener(
      onShow: () => _handleTransition('show'),
      onResume: () => _handleTransition('resume'),
      onHide: () => _handleTransition('hide'),
      onInactive: () => _handleTransition('inactive'),
      onPause: () => _handleTransition('pause'),
      onDetach: () => _handleTransition('detach'),
      onRestart: () => _handleTransition('restart'),
      // 每次状态改变都会触发
      onStateChange: _handleStateChange,
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  void _handleTransition(String name) {
    debugPrint("app:$name");
  }

  void _handleStateChange(AppLifecycleState state) {
    debugPrint("app状态每次改变我都会触发");
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
