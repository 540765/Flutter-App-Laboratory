import 'dart:math';

import 'package:flutter/material.dart';
import 'package:laboratory/app_responsive/utils/responsive_layout_config.dart';
import 'package:laboratory/app_responsive/utils/screen_type.dart';

class AppResponsiveLaboratory {
  ///全局唯一實例
  static final AppResponsiveLaboratory _appResponsiveLaboratory =
      AppResponsiveLaboratory._internal();
  factory AppResponsiveLaboratory() {
    return _appResponsiveLaboratory;
  }
  AppResponsiveLaboratory._internal();

  ///屏幕信息
  late MediaQueryData _screenData;

  ///屏幕配置信息
  late ResponsiveLayoutConfig _layoutConfig;

  ///屏幕方向
  late Orientation _orientation;

  ///app判断的当前屏幕类型
  late DeviceScreenType _deviceScreenType;

  ///文字縮放大小
  late double _scaleText;

  ///當前使用的設計稿大小
  late Size _designSize;

  ///init
  static void init(
    BuildContext context,
    ResponsiveLayoutConfig designSize,
    bool minAdapt,
  ) {
    return configure(
      data: MediaQuery.maybeOf(context),
      layoutConfig: designSize,
    );
  }

  ///配置
  static void configure(
      {MediaQueryData? data,
      required ResponsiveLayoutConfig layoutConfig}) async {
    try {
      if (data != null) {
        _appResponsiveLaboratory._screenData = data;
      } else {
        data = _appResponsiveLaboratory._screenData;
      }
      _appResponsiveLaboratory._layoutConfig = layoutConfig;
    } catch (e) {
      throw Exception(
          'You must either use ScreenUtil.init or ScreenUtilInit first');
    }

    final MediaQueryData? deviceData = data.nonEmptySizeOrNull();

    final Size deviceSize = deviceData?.size ?? layoutConfig.defaultSize;

    ///获取不到时宽小于高，我就认为你是竖屏
    final orientation = deviceData?.orientation ??
        (deviceSize.width < deviceSize.height
            ? Orientation.portrait
            : Orientation.landscape);

    ///竖屏状态下的设备类型
    if (orientation == Orientation.portrait) {
      await checkScreenType(
        deviceSize.width,
        deviceSize,
        layoutConfig,
        layoutConfig.watch,
        layoutConfig.mobile,
        layoutConfig.tablet,
        layoutConfig.desktop,
      );

      ///横屏状态下的设备类型
    } else if (orientation == Orientation.landscape) {
      await checkScreenType(
        deviceSize.height,
        deviceSize,
        layoutConfig,
        layoutConfig.watch,
        layoutConfig.mobile,
        layoutConfig.tablet,
        layoutConfig.desktop,
      );
    } else {
      throw Exception('Unknown Device Orientation');
    }

    _appResponsiveLaboratory
      .._orientation = deviceData?.orientation ?? orientation
      .._layoutConfig = layoutConfig;
  }

  static Future<void> checkScreenType(
    double size,
    Size deviceSize,
    ResponsiveLayoutConfig layoutConfig,
    double watch,
    double mobile,
    double tablet,
    double desktop,
  ) async {
    if (size < watch) {
      _appResponsiveLaboratory._deviceScreenType = DeviceScreenType.watch;
      _appResponsiveLaboratory._scaleText =
          min(deviceSize.width, deviceSize.height) /
              min(layoutConfig.watchDefaultSize.width,
                  layoutConfig.watchDefaultSize.height);
      _appResponsiveLaboratory._designSize = layoutConfig.watchDefaultSize;
    } else if (size >= watch && size < mobile) {
      _appResponsiveLaboratory._deviceScreenType = DeviceScreenType.mobile;
      _appResponsiveLaboratory._scaleText =
          min(deviceSize.width, deviceSize.height) /
              min(layoutConfig.mobileDefaultSize.width,
                  layoutConfig.mobileDefaultSize.height);
      _appResponsiveLaboratory._designSize = layoutConfig.mobileDefaultSize;
    } else if (size >= mobile && size < tablet) {
      _appResponsiveLaboratory._deviceScreenType = DeviceScreenType.tablet;
      _appResponsiveLaboratory._scaleText =
          min(deviceSize.width, deviceSize.height) /
              min(layoutConfig.tabletDefaultSize.width,
                  layoutConfig.tabletDefaultSize.height);
      _appResponsiveLaboratory._designSize = layoutConfig.tabletDefaultSize;
    } else {
      _appResponsiveLaboratory._deviceScreenType = DeviceScreenType.desktop;
      _appResponsiveLaboratory._scaleText =
          min(deviceSize.width, deviceSize.height) /
              min(layoutConfig.desktopDefaultSize.width,
                  layoutConfig.desktopDefaultSize.height);
      _appResponsiveLaboratory._designSize = layoutConfig.desktopDefaultSize;
    }
  }

  ///get
  ///屏幕方向
  Orientation get orientation => _orientation;

  ///app配置信息
  ResponsiveLayoutConfig get layoutConfig => _layoutConfig;

  ///app判断的当前屏幕类型
  DeviceScreenType get deviceScreenType => _deviceScreenType;

  /// The number of font pixels for each logical pixel.
  double get textScaleFactor => _screenData.textScaleFactor;

  ///设备的像素密度
  double? get pixelRatio => _screenData.devicePixelRatio;

  /// 当前设备宽度 dp
  double get screenWidth => _screenData.size.width;

  /// 当前设备宽度 dp
  double get screenHeight => _screenData.size.height;

  ///字體縮放比例
  double get scaleText => _scaleText;

  ///寬度縮放比例
  double get scaleWidth => screenWidth / _designSize.width;

  ///寬度縮放比例
  double get scaleHeigth => screenHeight / _designSize.height;
}

///擴展
extension on MediaQueryData? {
  MediaQueryData? nonEmptySizeOrNull() {
    if (this?.size.isEmpty ?? true) {
      return null;
    } else {
      return this;
    }
  }
}
