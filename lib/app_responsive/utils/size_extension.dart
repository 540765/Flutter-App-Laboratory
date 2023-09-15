import 'package:flutter/widgets.dart';
import 'package:laboratory/app_responsive/app_responsive.dart';
import 'package:laboratory/app_responsive/utils/screen_type.dart';

extension SizeExtension on num {
  ///[AppResponsive.setWidth]
  double get w => AppResponsive().setWidth(this);

  ///[AppResponsive.setHeight]
  double get h => AppResponsive().setHeight(this);

  ///[AppResponsive.radius]
  double get r => AppResponsive().radius(this);

  ///[AppResponsive.setSp]
  double get sp => AppResponsive().setSp(this);
}

extension OrientationExtension on Orientation {
  ///屏幕方向
  Orientation get screenOrientation => AppResponsive().orientation;
}

extension TypeExtension on Enum {
  ///屏幕方向
  DeviceScreenType get screenDeviceScreenType =>
      AppResponsive().deviceScreenType;
}
