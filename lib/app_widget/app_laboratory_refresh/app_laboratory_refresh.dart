import 'package:flutter/material.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/behavior/scroll_behavior.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/notifier/footer_notifier/footer_notifier.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/notifier/header_notifier/header_notifier.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/physics/scroll_physics.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/share_data/share_data.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/share_data/share_enum.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/style/classic/footer/classic_footer.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/style/classic/header/classic_header.dart';

class AppLaboratoryRefresh extends StatefulWidget {
  const AppLaboratoryRefresh({
    Key? key,
    required this.child,
    // this.simultaneously = false,
    // this.canRefreshAfterNoMore = false,
    // this.canLoadAfterNoMore = false,
    // this.resetAfterRefresh = true,
    // this.refreshOnStart = false,
    // this.callRefreshOverOffset = 20,
    // this.callLoadOverOffset = 20,
    this.triggerAxis = Axis.vertical,
  }) : super(key: key);
  // : assert(callRefreshOverOffset > 0,
  //         'callRefreshOverOffset must be greater than 0./必须大于0'),
  //     assert(callLoadOverOffset > 0,
  //         'callLoadOverOffset must be greater than 0./必须大于0'),
  //     super(key: key);

  ///用户widget
  final Widget child;

  // ///是否允许同时触发刷新和加载
  // final bool simultaneously;

  // ///当没有更多内容时，是否允许再次触发刷新
  // final bool canRefreshAfterNoMore;

  // ///当没有更多内容时，是否允许再次触发加载
  // final bool canLoadAfterNoMore;

  // ///刷新完成后是否重置，还是停在成功动画的最后一帧
  // final bool resetAfterRefresh;

  // ///初始化时是否触发刷新操作
  // final bool refreshOnStart;

  // ///触发刷新的阀值，滑动的距离
  // final double callRefreshOverOffset;

  // ///触发加载的阀值，滑动的距离
  // final double callLoadOverOffset;

  ///要支持滑动方向，垂直还是横向
  final Axis triggerAxis;

  @override
  State<StatefulWidget> createState() => AppLaboratoryRefreshState();
}

class AppLaboratoryRefreshState extends State<AppLaboratoryRefresh>
    with TickerProviderStateMixin {
  ///动画 [ScrollPhysics]
  late RefreshScrollPhysics physics;

  ///需要共享的数据
  late LaboratoryRefreshData data;

  @override
  void initState() {
    super.initState();

    ///初始化数据
    initDate();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    ///头部
    if (data.headerNotifier.indicator.position == IndicatorPosition.behind) {
      children.add(buildHeader());
    }
    //底部
    if (data.footerNotifier.indicator.position == IndicatorPosition.behind) {
      children.add(buildFooter());
    }

    ///内容
    children.add(buildContext());

    ///头部
    if (data.headerNotifier.indicator.position == IndicatorPosition.above) {
      children.add(buildHeader());
    }

    //底部
    if (data.footerNotifier.indicator.position == IndicatorPosition.above) {
      children.add(buildFooter());
    }
    return ClipPath(
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: children,
      ),
    );
  }

  ///初始化数据
  void initDate() {
    ///默认用户初始化时没有滑动
    final ValueNotifier<bool> defaultUserOffsetNotifier =
        ValueNotifier<bool>(false);

    ///刷新状态数据初始化
    data = LaboratoryRefreshData(
      userOffsetNotifier: defaultUserOffsetNotifier,
      headerNotifier: HeaderNotifier(
        userOffsetNotifier: defaultUserOffsetNotifier,
        vsync: this,
        header: ClassicHeader(),
        axis: widget.triggerAxis,
      ),
      footerNotifier: FooterNotifier(
        userOffsetNotifier: defaultUserOffsetNotifier,
        vsync: this,
        footer: ClassicFooter(),
        axis: widget.triggerAxis,
      ),
    );

    ///动画初始化
    physics = RefreshScrollPhysics(
      userOffsetNotifier: data.userOffsetNotifier,
      headerNotifier: data.headerNotifier,
      footerNotifier: data.footerNotifier,
    );
  }

  ///构建头部
  Widget buildHeader() {
    return ValueListenableBuilder(
      valueListenable: data.headerNotifier.listenable(),
      builder: (BuildContext context, notifier, Widget? child) {
        if (data.headerNotifier.axisDirection == null) {
          return const SizedBox.shrink();
        }
        debugPrint('headerNotifier渲染');
        final axis = data.headerNotifier.triggerAxis;
        final axisDirection = data.headerNotifier.axisDirection;
        return Positioned(
          top: axis == Axis.vertical
              ? axisDirection == AxisDirection.down
                  ? 0
                  : null
              : 0,
          bottom: axis == Axis.vertical
              ? axisDirection == AxisDirection.up
                  ? 0
                  : null
              : 0,
          left: axis == Axis.horizontal
              ? axisDirection == AxisDirection.right
                  ? 0
                  : null
              : 0,
          right: axis == Axis.horizontal
              ? axisDirection == AxisDirection.left
                  ? 0
                  : null
              : 0,
          child: data.headerNotifier.build(context),
        );
      },
    );
  }

  ///构建底部
  Widget buildFooter() {
    return ValueListenableBuilder(
      valueListenable: data.footerNotifier.listenable(),
      builder: (BuildContext context, notifier, Widget? child) {
        if (data.headerNotifier.axisDirection == null) {
          return const SizedBox.shrink();
        }
        debugPrint('footerNotifier渲染');
        final axis = data.footerNotifier.triggerAxis;
        final axisDirection = data.footerNotifier.axisDirection;
        return Positioned(
          top: axis == Axis.vertical
              ? axisDirection == AxisDirection.down
                  ? 0
                  : null
              : 0,
          bottom: axis == Axis.vertical
              ? axisDirection == AxisDirection.up
                  ? 0
                  : null
              : 0,
          left: axis == Axis.horizontal
              ? axisDirection == AxisDirection.right
                  ? 0
                  : null
              : 0,
          right: axis == Axis.horizontal
              ? axisDirection == AxisDirection.left
                  ? 0
                  : null
              : 0,
          child: data.footerNotifier.build(context),
        );
      },
    );
  }

  ///构建用户child
  Widget buildContext() {
    return InheritedLaboratoryRefresh(
      data: data,
      child: ScrollConfiguration(
        behavior: RefreshScrollBehavior(physics),
        child: widget.child,
      ),
    );
  }
}
