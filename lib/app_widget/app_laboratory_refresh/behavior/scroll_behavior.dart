import 'dart:ui';
import 'package:flutter/widgets.dart';

/// Define [ScrollBehavior] in the scope of EasyRefresh.
/// Add support for web and PC.
class RefreshScrollBehavior extends ScrollBehavior {
  static final Set<PointerDeviceKind> _kDragDevices =
      PointerDeviceKind.values.toSet();

  final ScrollPhysics? _physics;

  const RefreshScrollBehavior([this._physics]);

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return _physics ?? super.getScrollPhysics(context);
  }

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }

  @override
  Set<PointerDeviceKind> get dragDevices => _kDragDevices;
}
