import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui show FlutterView;

import 'package:flutter/material.dart';
import 'package:laboratory/app_responsive/utils/responsive_layout_config.dart';
import 'package:laboratory/app_responsive/utils/screen_type.dart';

class AppResponsive {
  ///全局唯一實例
  static final AppResponsive _appResponsive = AppResponsive._internal();
  factory AppResponsive() {
    return _appResponsive;
  }
  AppResponsive._internal();

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
  static void configure(
    MediaQueryData? data,
    ResponsiveLayoutConfig layoutConfig,
    bool minAdapt,
  ) {
    try {
      if (data != null) {
        _appResponsive._screenData = data;
      } else {
        data = _appResponsive._screenData;
      }
      _appResponsive._layoutConfig = layoutConfig;
    } catch (e) {
      throw Exception(
          'You must either use ScreenUtil.init or ScreenUtilInit first');
    }

    final MediaQueryData? deviceData = data.nonEmptySizeOrNull();

    final Size deviceSize = deviceData?.size ?? layoutConfig.defaultSize;

    ///获取不到时宽小于高，我就认为你是竖屏
    final Orientation orientation = deviceData?.orientation ??
        (deviceSize.width < deviceSize.height
            ? Orientation.portrait
            : Orientation.landscape);

    ///竖屏状态下的设备类型
    if (orientation == Orientation.portrait) {
      checkScreenType(
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
      checkScreenType(
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

    _appResponsive
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
    if (size < mobile) {
      _appResponsive._deviceScreenType = DeviceScreenType.watch;
      _appResponsive._scaleText = min(deviceSize.width, deviceSize.height) /
          min(layoutConfig.watchDefaultSize.width,
              layoutConfig.watchDefaultSize.height);
      _appResponsive._designSize = layoutConfig.watchDefaultSize;
    } else if (size < tablet) {
      _appResponsive._deviceScreenType = DeviceScreenType.mobile;
      _appResponsive._scaleText = min(deviceSize.width, deviceSize.height) /
          min(layoutConfig.mobileDefaultSize.width,
              layoutConfig.mobileDefaultSize.height);
      _appResponsive._designSize = layoutConfig.mobileDefaultSize;
    } else if (size < desktop) {
      _appResponsive._deviceScreenType = DeviceScreenType.tablet;
      _appResponsive._scaleText = min(deviceSize.width, deviceSize.height) /
          min(layoutConfig.tabletDefaultSize.width,
              layoutConfig.tabletDefaultSize.height);
      _appResponsive._designSize = layoutConfig.tabletDefaultSize;
    } else {
      _appResponsive._deviceScreenType = DeviceScreenType.desktop;
      _appResponsive._scaleText = min(deviceSize.width, deviceSize.height) /
          min(layoutConfig.desktopDefaultSize.width,
              layoutConfig.desktopDefaultSize.height);
      _appResponsive._designSize = layoutConfig.desktopDefaultSize;
    }
  }

  static Future<void> ensureScreenSize([
    ui.FlutterView? window,
    Duration duration = const Duration(milliseconds: 10),
  ]) async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    binding.deferFirstFrame();

    await Future.doWhile(() {
      window ??= binding.platformDispatcher.implicitView;
      if (window == null || window!.physicalSize.isEmpty) {
        return Future.delayed(duration, () => true);
      }

      return false;
    });

    binding.allowFirstFrame();
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
  double get scaleHeight => screenHeight / _designSize.height;

  ///获取适配后的值
  ///宽度
  double setWidth(num width) => width * scaleWidth;

  ///高度
  double setHeight(num height) => height * scaleHeight;

  ///根据宽度或高度中的较小值进行适配
  ///根据宽度或高度中较小的一个进行适配
  double radius(num r) => r * min(scaleWidth, scaleHeight);

  /// 根据宽度和高度进行自适应
  double diagonal(num d) => d * scaleHeight * scaleWidth;
  
  ///字体缩放，这里没有很多操作，需要自己扩展
  double setSp(num fontSize) => fontSize * scaleText;
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
