import 'package:flutter/widgets.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/indicator/indicator.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/share_data/share_enum.dart';
///指示器的状态
class IndicatorState {
  /// Refresh and loading indicator.
  final Indicator indicator;

  /// Refresh and loading notifier.
  // final IndicatorNotifier notifier;

  /// User offset notifier.
  final ValueNotifier<bool> userOffsetNotifier;

  /// Refresh and loading state.
  final IndicatorMode mode;

  // /// Task completion result.
  // final IndicatorResult result;

  /// Overscroll offset.
  final double offset;

  // /// Safe area offset.
  // final double safeOffset;

  /// [Scrollable] axis.
  final Axis axis;

  // /// [Scrollable] axis direction.
  // final AxisDirection axisDirection;

  // /// [Scrollable] viewport dimension.
  // /// It's helpful for full screen indicator and second floor views.
  // final double viewportDimension;

  // /// Actual trigger offset.
  // /// [triggerOffset] + [safeOffset]
  // final double actualTriggerOffset;

  // /// Whether the scroll view direction is reversed.
  // /// [AxisDirection.up] or [AxisDirection.left]
  // bool get reverse =>
  //     axisDirection == AxisDirection.up || axisDirection == AxisDirection.left;

  const IndicatorState({
    required this.indicator,
    // required this.notifier,
    required this.userOffsetNotifier,
    required this.mode,
    // required this.result,
    required this.offset,
    // required this.safeOffset,
    required this.axis,
    // required this.axisDirection,
    // required this.viewportDimension,
    // required this.actualTriggerOffset,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndicatorState &&
          runtimeType == other.runtimeType &&
          indicator == other.indicator &&
          // notifier == other.notifier &&
          mode == other.mode &&
          // result == other.result &&
          offset == other.offset &&
          // safeOffset == other.safeOffset &&
          axis == other.axis;
  // axisDirection == other.axisDirection &&
  // viewportDimension == other.viewportDimension &&
  // actualTriggerOffset == other.actualTriggerOffset;

  @override
  int get hashCode =>
      indicator.hashCode ^
      // notifier.hashCode ^
      mode.hashCode ^
      // result.hashCode ^
      offset.hashCode ^
      // safeOffset.hashCode ^
      axis.hashCode;
  // axisDirection.hashCode ^
  // viewportDimension.hashCode ^
  // actualTriggerOffset.hashCode;
}
