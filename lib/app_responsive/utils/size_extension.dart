import 'package:flutter/widgets.dart';
import 'package:laboratory/app_responsive/app_responsive_laboratory.dart';
import 'package:laboratory/app_responsive/utils/screen_type.dart';

extension OrientationExtension on Orientation {

  ///屏幕方向
  Orientation get screenOrientation => AppResponsiveLaboratory().orientation;
}

extension TypeExtension on Enum {

  ///屏幕方向
  DeviceScreenType get screenDeviceScreenType => AppResponsiveLaboratory().deviceScreenType;
}

