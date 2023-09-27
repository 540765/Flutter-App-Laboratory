import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/indicator/indicator.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/indicator/indicator_state.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/notifier/indicator_listenable.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/physics/scroll_physics.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/share_data/share_enum.dart';

///负责管理指示器的数据以及触发通知
abstract class IndicatorNotifier extends ChangeNotifier {
  IndicatorNotifier({
    required Indicator getIndicator,
    required this.userOffsetNotifier,
    required this.vsync,
    bool waitTaskResult = true,
    FutureOr Function()? taskFunction,
    required Axis axis,
  })  : indicator = getIndicator,
        triggerAxis = axis,
        task = taskFunction {
    debugPrint('IndicatorNotifier init');
    _initClampingAnimation();
    userOffsetNotifier.addListener(_onUserOffset);
    mounted = true;
  }

  ///指示器
  Indicator indicator;

  ///指示器的状态
  IndicatorMode mode = IndicatorMode.inactive;

  ///任务的结果
  IndicatorResult result = IndicatorResult.none;

  ///记录超出滚动的距离
  double offset = 0.0;

  ///记录用户手指的状态,滑动和释放手指
  @protected
  final ValueNotifier<bool> userOffsetNotifier;

  /// 动画计时器 [clamping] animation.
  final TickerProviderStateMixin vsync;

  /// 状态改变时的回调函数，每一帧后都会调用这个吧
  /// Can return [IndicatorResult] to set the completion result.
  /// 可以返回 [IndicatorResult] 来设置完成结果。
  FutureOr Function()? task;

  /// 需要监听动画类.
  late RefreshScrollPhysics physics;

  /// 触顶和触低动画控制器
  /// Used when [clamping] is true.
  AnimationController? clampingAnimationController;

  ///监听器是否已经挂载
  bool mounted = false;

  ///绑定动画
  void bindPhysics(RefreshScrollPhysics physicsBind) {
    physics = physicsBind;
  }

  ///滑动的信息
  ScrollMetrics? position;

  ///初始化动画控制器
  void _initClampingAnimation() {
    debugPrint('initClampingAnimation');
    clampingAnimationController = AnimationController.unbounded(
      vsync: vsync,
    );
    clampingAnimationController!.addListener(() {
      if (mounted) {
        debugPrint('clampingAnimationController addListener');
        notifyListeners();
      }
    });
  }

  ///监听用户是否放开手指
  void _onUserOffset() {
    if (userOffsetNotifier.value) {
      debugPrint('还没松手，暂停动画：${userOffsetNotifier.value}');
      if (clampingAnimationController!.isAnimating) {
        clampingAnimationController!.stop(canceled: true);
      }
    } else {
      debugPrint('放开手指：${userOffsetNotifier.value}');
    }
  }

  ///是否锁定
  ///[IndicatorMode.processing] or [IndicatorMode.processed]
  ///此状态说明在刷新中，拒绝任何操作
  bool get modeLocked =>
      mode == IndicatorMode.processing || mode == IndicatorMode.processed;

  ///页面滑动触发
  ///[value] 滑动的距离
  ///[bySimulation] 是否是模拟触发
  ///[position] 滑动的位置信息
  void updateOffset(ScrollMetrics position, double value, bool bySimulation) {
    if (modeLocked) {
      //要判断是否已经在刷新过程中，如果有进行的任务则不进行任何操作
      return;
    }
    //记录滑动的信息
    this.position = position;
    //没有刷新任务要判断这次是否满足刷新任务条件
    final oldOffset = offset;
    final oldMode = mode;
    //计算滑动距离--其实这里大部分情况都等于value
    offset = calculateOffset(position, value);
    if ((oldOffset == 0 && offset == 0) && (oldMode == mode)) {
      //新旧都等于0并且状态也相同
      //可能是没有到达边缘或者任务在1进行中
      //返回
      return;
    }
    //判断是否更新指示器状态
    updateMode(oldOffset);

    //更新指示器
    notifyListeners();
  }

  void updateMode([double? oldOffset]) {
    //先判断滚动方向是否为需要的
    if (triggerAxis != axis) {
      return;
    }
    //没有刷新任务也应该return
    if (task == null) {
      return;
    }
    //判断是否在刷新中
    if (!modeLocked) {
      //任务处于已经完成状态
      if (mode == IndicatorMode.done &&
          position!.maxScrollExtent != position!.minScrollExtent) {
        //要定义一个结果来判断是否改变mode状态
        //如果结果为失败，说明任务已经结束
        if (result == IndicatorResult.fail ||
            result == IndicatorResult.noMore &&
                oldOffset != null &&
                oldOffset < offset) {
          //任务失败状态时恢复状态
          result = IndicatorResult.none;
          //这里还在进行中是因为要展示一会结果
          mode = IndicatorMode.processing;
        }else{
          //任务成功状态时恢复状态
          return;
        }
      }
    }
  }

  /// 指示器监听器
  ValueListenable<IndicatorNotifier> listenable() => IndicatorListenable(this);

  /// 获取滚动方向
  AxisDirection? axisDirection;

  /// 获取列表方向---注意这个是自动获取
  Axis? axis;

  /// [Scrollable] 的方向,滑动方向---这个是用户传入的方向
  Axis triggerAxis;

  ///此方法由[ScrollPhysics.createBallisticSimulation]通知更新
  void updateBySimulation(ScrollMetrics position, double velocity) {
    if (axis != position.axis || axisDirection != position.axisDirection) {
      axis = position.axis;
      axisDirection = position.axisDirection;
      Future(() {
        ///滑动状态有变，更新
        notifyListeners();
      });
    }
    this.position = position;
  }

  ///指示器的状态
  IndicatorState get indicatorState {
    return IndicatorState(
      indicator: indicator,
      userOffsetNotifier: userOffsetNotifier,
      axis: triggerAxis,
      mode: mode,
      offset: offset,
    );
  }

  ///需要重写
  Widget build(BuildContext context) {
    return indicator.build(context, indicatorState);
  }

  ///需要重写-涉及性能
  ///此方法计算达到边缘时的滑动距离
  ///[ScrollMetrics position] 滑动信息
  ///[double value] 滑动距离
  double calculateOffset(ScrollMetrics position, double value);
}
