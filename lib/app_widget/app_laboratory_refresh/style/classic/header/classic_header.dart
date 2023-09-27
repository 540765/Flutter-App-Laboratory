import 'package:flutter/widgets.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/indicator/footer/footer.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/indicator/indicator_state.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/style/classic/classic_indicator.dart';

class ClassicFooter extends Footer {
  final Key? key;
  ClassicFooter({
    this.key,
    double triggerOffset = 70,
  }) : super(
          triggerOffset: triggerOffset,
        );

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return ClassicIndicator(
      state: state,
    );
  }
}
