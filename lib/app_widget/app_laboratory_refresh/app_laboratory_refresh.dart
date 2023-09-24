import 'package:flutter/widgets.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/behavior/scroll_behavior.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/physics/scroll_physics.dart';

class AppLaboratoryRefresh extends StatefulWidget {
  const AppLaboratoryRefresh({
    Key? key,
    required this.child,
    this.simultaneously = false,
    this.canRefreshAfterNoMore = false,
    this.canLoadAfterNoMore = false,
    this.resetAfterRefresh = true,
    this.refreshOnStart = false,
    this.callRefreshOverOffset = 20,
    this.callLoadOverOffset = 20,
    this.triggerAxis,
  })  : assert(callRefreshOverOffset > 0,
            'callRefreshOverOffset must be greater than 0./必须大于0'),
        assert(callLoadOverOffset > 0,
            'callLoadOverOffset must be greater than 0./必须大于0'),
        super(key: key);

  ///用户widget
  final Widget child;

  ///是否允许同时触发刷新和加载
  final bool simultaneously;

  ///当没有更多内容时，是否允许再次触发刷新
  final bool canRefreshAfterNoMore;

  ///当没有更多内容时，是否允许再次触发加载
  final bool canLoadAfterNoMore;

  ///刷新完成后是否重置，还是停在成功动画的最后一帧
  final bool resetAfterRefresh;

  ///初始化时是否触发刷新操作
  final bool refreshOnStart;

  ///触发刷新的阀值，滑动的距离
  final double callRefreshOverOffset;

  ///触发加载的阀值，滑动的距离
  final double callLoadOverOffset;

  ///滑动方向，垂直还是横向
  final Axis? triggerAxis;

  @override
  State<StatefulWidget> createState() => AppLaboratoryRefreshState();
}

class AppLaboratoryRefreshState extends State<AppLaboratoryRefresh> with TickerProviderStateMixin{
  ///动画 [ScrollPhysics]
  late RefreshScrollPhysics physics;

  ///需要共享的数据

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    children.add(buildContext());
    return Stack(
      children: children,
    );
  }

  ///初始化数据
  void initDate() {
    ///动画初始化
    physics = const RefreshScrollPhysics();
  }

  ///构建用户child
  Widget buildContext() {
    return ScrollConfiguration(
      behavior: const RefreshScrollBehavior(),
      child: widget.child,
    );
  }
}
