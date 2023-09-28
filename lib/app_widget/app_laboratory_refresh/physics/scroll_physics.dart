import 'package:flutter/material.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/notifier/footer_notifier/footer_notifier.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/notifier/header_notifier/header_notifier.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/share_data/share_enum.dart';

///摩擦因子，表现为越滑动越困难
typedef FrictionFactor = double Function(double overscrollFraction);

class RefreshScrollPhysics extends BouncingScrollPhysics {
  RefreshScrollPhysics({
    ScrollPhysics? parent = const AlwaysScrollableScrollPhysics(),
    required this.userOffsetNotifier,
    required this.headerNotifier,
    required this.footerNotifier,
  }) : super(parent: parent) {
    headerNotifier.bindPhysics(this);
    footerNotifier.bindPhysics(this);
    headerSimulationCreationState =
        ValueNotifier(BallisticSimulationCreationState(
      mode: headerNotifier.mode,
      offset: headerNotifier.offset,
      actualTriggerOffset: 70,
    ));
    footerSimulationCreationState =
        ValueNotifier(BallisticSimulationCreationState(
      mode: footerNotifier.mode,
      offset: footerNotifier.offset,
      actualTriggerOffset: 70,
    ));
  }

  final ValueNotifier<bool> userOffsetNotifier;
  final HeaderNotifier headerNotifier;
  final FooterNotifier footerNotifier;

  /// 创建 BallisticSimulation 时指示器的状态。
  late final ValueNotifier<BallisticSimulationCreationState>
      headerSimulationCreationState;
  late final ValueNotifier<BallisticSimulationCreationState>
      footerSimulationCreationState;

  ///动画更新传递上一帧的东西
  @override
  RefreshScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return RefreshScrollPhysics(
      parent: buildParent(ancestor),
      userOffsetNotifier: userOffsetNotifier,
      headerNotifier: headerNotifier,
      footerNotifier: footerNotifier,
    );
  }

  ///获取摩擦系数
  @override
  SpringDescription get spring {
    return super.spring;
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    userOffsetNotifier.value = true;
    return super.applyPhysicsToUserOffset(position, offset);
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    updateAxis(position);

    //滑动到达顶部
    if (value < position.minScrollExtent) {
      updateIndicatorOffset(position, value, value);
    }

    ///滑动到达底部
    if (value > position.maxScrollExtent) {
      updateIndicatorOffset(position, value, value);
    }
    return super.applyBoundaryConditions(position, value);
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    userOffsetNotifier.value = false;
    headerNotifier.updateBySimulation(position, velocity);
    footerNotifier.updateBySimulation(position, velocity);
    //构建弹道模拟
    final hState = BallisticSimulationCreationState(
      mode: headerNotifier.mode,
      offset: headerNotifier.offset,
      actualTriggerOffset: 70,
    );
    final fState = BallisticSimulationCreationState(
      mode: footerNotifier.mode,
      offset: footerNotifier.offset,
      actualTriggerOffset: 70,
    );
    headerSimulationCreationState.value = hState;
    footerSimulationCreationState.value = fState;
    //判断是否需要创建弹道模拟
    if (headerSimulationCreationState.value.needCreation(hState) ||
        footerSimulationCreationState.value.needCreation(fState)) {
      return null;
    }
    return super.createBallisticSimulation(position, velocity);
  }

  ///更新指示器--页面滑动时触发
  void updateIndicatorOffset(
      ScrollMetrics position, double offset, double value) {
    if (headerNotifier.offset > 0 && value > position.minScrollExtent) {
      return;
    }
    headerNotifier.updateOffset(position, offset, false);
    footerNotifier.updateOffset(position, offset, false);
  }

  ///更新滑动方向
  void updateAxis(ScrollMetrics position) {
    if (headerNotifier.axis != position.axis ||
        headerNotifier.axisDirection != position.axisDirection) {
      headerNotifier.axis = position.axis;
      headerNotifier.axisDirection = position.axisDirection;
    }
    if (footerNotifier.axis != position.axis ||
        footerNotifier.axisDirection != position.axisDirection) {
      footerNotifier.axis = position.axis;
      footerNotifier.axisDirection = position.axisDirection;
    }
  }
}

/// 创建弹道模拟时指示器的状态。
/// 用于确定是否需要创建弹道模拟。
class BallisticSimulationCreationState {
  final IndicatorMode mode;
  final double offset;
  final double actualTriggerOffset;

  const BallisticSimulationCreationState({
    required this.mode,
    required this.offset,
    required this.actualTriggerOffset,
  });

  bool needCreation(BallisticSimulationCreationState newState) {
    return mode != newState.mode ||
        offset != newState.offset ||
        (newState.mode == IndicatorMode.ready &&
            newState.offset >= actualTriggerOffset);
  }
}
