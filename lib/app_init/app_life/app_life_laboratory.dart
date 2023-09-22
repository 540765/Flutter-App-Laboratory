import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class AppLifeLaboratory extends StatefulWidget {
  const AppLifeLaboratory({super.key, required this.child});
  final Widget child;
  @override
  State<AppLifeLaboratory> createState() => AppLifeLaboratoryState();
}

class AppLifeLaboratoryState extends State<AppLifeLaboratory> {
  late final AppLifecycleListener listener;
  late AppLifecycleState? state;
  late String? stateName;

  @override
  void initState() {
    super.initState();
    state = SchedulerBinding.instance.lifecycleState;
    listener = AppLifecycleListener(
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
    listener.dispose();
    super.dispose();
  }

  void _handleTransition(String name) {
    debugPrint("app:$name");
    ///setState不可取，我这里只是为了配合widget测试
    setState(() {
      stateName = name;
    });
  }

  void _handleStateChange(AppLifecycleState state) {
    debugPrint("app状态每次改变我都会触发");
    ///setState不可取，我这里只是为了配合widget测试
    setState(() {
      this.state = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
