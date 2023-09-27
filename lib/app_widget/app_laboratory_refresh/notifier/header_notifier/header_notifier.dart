import 'package:flutter/widgets.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/indicator/header/header.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/notifier/indicator_notifier.dart';

class HeaderNotifier extends IndicatorNotifier {
  HeaderNotifier({
    required Header header,
    required ValueNotifier<bool> userOffsetNotifier,
    required TickerProviderStateMixin vsync,
    required Axis axis,
  }) : super(
          getIndicator: header,
          userOffsetNotifier: userOffsetNotifier,
          vsync: vsync,
          axis: axis,
        );

  ///计算头部滑动距离
  @override
  double calculateOffset(ScrollMetrics position, double value) {
    if (value >= position.minScrollExtent && offset != 0 && !(offset > 0)) {
      //滑动到顶部弹出但是放手了
      return 0;
    }
    //滑动的距离计算
    final move = position.minScrollExtent - value;
    return value > position.minScrollExtent ? 0 : move;
  }
}
