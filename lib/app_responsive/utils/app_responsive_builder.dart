import 'package:flutter/widgets.dart';
import 'package:laboratory/app_responsive/app_responsive.dart';
import 'package:laboratory/app_responsive/utils/screen_type.dart';

class AppResponsiveBuilder extends StatelessWidget {
  const AppResponsiveBuilder({
    super.key,
    required this.landscapeMobileBuilder,
    required this.portraitMobileBuilder,
    required this.landscapeWatchBuilder,
    required this.portraitWatchBuilder,
    required this.landscapeTabletBuilder,
    required this.portraitTabletBuilder,
    required this.landscapeDesktopBuilder,
    required this.portraitDesktopBuilder,
  });

  ///手机
  final WidgetBuilder landscapeMobileBuilder;
  final WidgetBuilder portraitMobileBuilder;

  ///平板
  final WidgetBuilder landscapeTabletBuilder;
  final WidgetBuilder portraitTabletBuilder;

  ///电脑
  final WidgetBuilder landscapeDesktopBuilder;
  final WidgetBuilder portraitDesktopBuilder;

  ///手表
  final WidgetBuilder landscapeWatchBuilder;
  final WidgetBuilder portraitWatchBuilder;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = AppResponsive().orientation;
    DeviceScreenType screenDeviceScreenType =
        AppResponsive().deviceScreenType;
    if (orientation == Orientation.landscape) {
      switch (screenDeviceScreenType) {
        case DeviceScreenType.watch:
          return landscapeWatchBuilder(context);
        case DeviceScreenType.mobile:
          return landscapeMobileBuilder(context);
        case DeviceScreenType.tablet:
          return landscapeTabletBuilder(context);
        case DeviceScreenType.desktop:
          return landscapeDesktopBuilder(context);
        default:
          throw UnimplementedError();
      }
    } else {
      switch (screenDeviceScreenType) {
        case DeviceScreenType.watch:
          return portraitWatchBuilder(context);
        case DeviceScreenType.mobile:
          return portraitMobileBuilder(context);
        case DeviceScreenType.tablet:
          return portraitTabletBuilder(context);
        case DeviceScreenType.desktop:
          return portraitDesktopBuilder(context);
        default:
          throw UnimplementedError();
      }
    }
  }
}
