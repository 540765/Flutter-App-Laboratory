import 'package:flutter/material.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/indicator/header/header.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/indicator/indicator_state.dart';
import 'package:laboratory/app_widget/app_laboratory_refresh/style/classic/classic_indicator.dart';

class ClassicHeader extends Header {
  final Key? key;
  ClassicHeader({
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
