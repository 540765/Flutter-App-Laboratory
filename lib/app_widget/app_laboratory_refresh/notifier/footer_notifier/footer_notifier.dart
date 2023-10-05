import 'package:flutter/widgets.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/indicator/footer/footer.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/notifier/indicator_notifier.dart';

class FooterNotifier extends IndicatorNotifier {
  FooterNotifier({
    required Footer footer,
    required ValueNotifier<bool> userOffsetNotifier,
    required TickerProviderStateMixin vsync,
    required Axis axis,
  }) : super(
          getIndicator: footer,
          userOffsetNotifier: userOffsetNotifier,
          vsync: vsync,
          axis: axis,
        );

  //计算到达底部的距离
  @override
  double calculateOffset(ScrollMetrics position, double value) {
    if (value <= position.maxScrollExtent && offset != 0 && !(offset > 0)) {
      return 0;
    }
    final move = value - position.maxScrollExtent;
    return value < position.maxScrollExtent ? 0 : move;
  }

  @override
  double get edgeOffset => position!.pixels - position!.maxScrollExtent;
}
