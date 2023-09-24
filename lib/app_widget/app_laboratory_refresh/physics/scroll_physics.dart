import 'package:flutter/material.dart';

///摩擦因子，表现为越滑动越困难
typedef FrictionFactor = double Function(double overscrollFraction);

class RefreshScrollPhysics extends BouncingScrollPhysics {
  const RefreshScrollPhysics({
    ScrollPhysics? parent = const AlwaysScrollableScrollPhysics(),
  }) : super(parent: parent);
}
