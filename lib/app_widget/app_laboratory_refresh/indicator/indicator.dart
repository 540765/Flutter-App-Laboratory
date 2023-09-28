import 'package:flutter/widgets.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/indicator/indicator_state.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/share_data/share_enum.dart';

///指示器的抽象类，用于自定义指示器
///负责渲染指示器
abstract class Indicator {
  const Indicator({
    required this.triggerOffset,
    this.position = IndicatorPosition.above, 
  });

  // ///触发指示器的滑动距离
  final double triggerOffset;

  // ///是否允许滚动超出边界，true为不允许，注意允许是不要有无效滚动为好
  // final bool clamping;

  // /// 安全区域
  // final bool safeArea;

  // ///动画完成后的结束延迟
  // final Duration processedDuration;

  // ///垂直方向上的回弹，阻尼系数
  // final SpringDescription? spring;

  // ///水平方向上的回弹，阻尼系数
  // final SpringDescription? horizontalSpring;

  // ///构建垂直方向上的回弹
  // ///仅在：[IndicatorMode.ready]
  // final SpringBuilder? readySpringBuilder;

  // ///构建水平方向上的回弹
  // //////仅在：[IndicatorMode.ready]
  // final SpringBuilder? horizontalReadySpringBuilder;

  // ///它表示弹簧是否可以回弹。
  // ///springRebound 属性仅对 readySpringBuilder 参数起作用。
  // ///当 springRebound 设置为 true 时，在指示器从 "ready" 模式切换到其他模式时，弹簧效果会触发回弹动画。
  // final bool springRebound;

  // ///当列表超出边界时，它表示摩擦因子。
  // ///frictionFactor 属性是一个 FrictionFactor 类型的参数，用于控制滚动物理效果中的摩擦力。
  // ///通过设置 frictionFactor 参数，可以调整超出边界时列表的滑动行为。
  // final FrictionFactor? frictionFactor;

  // ///同上面，但是作用于水平方向
  // final FrictionFactor? horizontalFrictionFactor;

  // ///它表示无限滚动的触发偏移量。
  // ///infiniteOffset 属性是一个 double 类型的参数，用于定义相对于边界的偏移量（大于等于 0）。
  // ///当 infiniteOffset 参数为 null 时，表示没有无限滚动效果。
  // ///通过设置 infiniteOffset 参数，可以实现在滚动到边界时触发无限滚动的效果。
  // final double? infiniteOffset;

  // ///它表示当 Scrollable 自动滚动时，是否超出边界
  // ///当 clamping 设置为 false 时，hitOver 属性生效。
  // ///当 hitOver 设置为 true 时，在 Scrollable 自动滚动时，如果滚动超出边界，会触发相应的行为。
  // final bool hitOver;

  // /// 它表示无限滚动是否超出边界。
  // /// 当 Scrollable 自动滚动时，如果启用了无限滚动，并且 clamping 设置为 false，infiniteHitOver 属性生效。
  // /// 当 infiniteHitOver 设置为 true 时，当无限滚动超出边界时，会触发相应的行为。
  // final bool infiniteHitOver;

  // ///它表示指示器的位置。
  // /// position 属性是一个 IndicatorPosition 类型的参数，用于指定指示器在 Scrollable 中的位置，可以是顶部、底部或其他位置。
  final IndicatorPosition position;

  // /// 它表示是否启用触觉反馈。
  // /// 当 hapticFeedback 设置为 true 时，在特定的操作或事件发生时，会触发触觉反馈效果。
  // /// 通过设置 hapticFeedback 参数，可以为用户提供触觉上的反馈，以增强交互体验。
  // final bool hapticFeedback;

  // ///二级页面触发的偏移量
  // ///当指定了 secondaryTriggerOffset 参数时，指示器将会展开并填充整个滚动视图区域
  // ///当 secondaryTriggerOffset 参数为 null 时，不会触发次要触发效果
  // final double? secondaryTriggerOffset;

  // ///二级页面开启速度
  // ///用于控制次要触发效果的开启速度。
  // final double? secondaryVelocity;

  // ///二级页面的尺寸
  // ///默认值为 [ScrollMetrics.viewportDimension]，即滚动视图的视口尺寸。
  // /// 可以通过指定 secondaryDimension 参数来自定义第二层的尺寸。
  // final double? secondaryDimension;

  // ///次要关闭触发偏移量。
  // ///用于控制次要触发效果的关闭触发偏移量。
  // final double secondaryCloseTriggerOffset;

  // ///当指示器不可见时是否进行通知
  // ///当 [IndicatorNotifier.offset] < 0 时，滚动仍然会触发通知
  // ///当需要时，可以设置 notifyWhenInvisible 参数来在指示器不可见时触发通知。这可能会带来额外的性能开销，但在需要时非常有用。
  // final bool notifyWhenInvisible;

  // ////指示器状态的可监听对象。
  // ///可以实时监听指示器状态的变化。
  // ///通过提供 IndicatorStateListenable 对象，可以监听指示器的状态变化
  // final IndicatorStateListenable? listenable;

  // ///当达到 triggerOffset 时立即触发
  // ///当设置 triggerWhenReach 参数为 true 时，当滚动达到触发偏移量时，指示器将立即触发相应的动作
  // final bool triggerWhenReach;

  // /// Over [triggerOffset],
  // /// 超过 [triggerOffset]，立即触发释放。
  // //  最终布尔触发器何时释放；
  // final bool triggerWhenRelease;

  // ///当超过 triggerOffset 时，立即触发释放
  // ///不需要等待任务执行完成，通常用于非异步事件或外部自定义指示器
  // ///当设置 triggerWhenReleaseNoWait 参数为 true 时，超过触发偏移量时将立即触发相应的释放行为。
  // final bool triggerWhenReleaseNoWait;

  // ///最大超出滚动偏移量，超过该偏移量将不再滚动
  // ///当设置 maxOverOffset 参数为 [double.infinity] 时，表示没有限制
  // ///通过指定 maxOverOffset 参数，可以限制指示器的最大超出滚动偏移量，以避免超出预期范围
  // final double maxOverOffset;

  Widget build(BuildContext context, IndicatorState state);
}
