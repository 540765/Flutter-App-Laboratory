import 'package:flutter/physics.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/share_data/share_enum.dart';

/// 使用 [IndicatorMode] 和偏移量构建 spring。
/// [mode] 指示器模式。
/// [offset] 指示器偏移量。
/// [actualTriggerOffset] 指标实际触发偏移。
/// [velocity] 指标实际触发偏移。
typedef SpringBuilder = SpringDescription Function({
  required IndicatorMode mode,
  required double offset,
  required double actualTriggerOffset,
  required double velocity,
});

///返回一个摩擦系数，用于计算滚动摩擦。
typedef FrictionFactor = double Function(double overscrollFraction);

/// Indicator widget builder.
typedef CanProcessCallBack = bool Function();