import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laboratory/app_responsive/export_app_responsive.dart';

void main() {
  ///模拟手表 屏幕大小
  const uiWatchSize = Size(160, 160);
  const uiWatchDeviceData = MediaQueryData(size: uiWatchSize);

  ///模拟手机 屏幕大小
  const uiMobileSize = Size(470, 750);
  const uiMobileDeviceData = MediaQueryData(size: uiMobileSize);

  ///模拟平板 屏幕大小
  const uiTabletSize = Size(800, 1024);
  const uiTabletDeviceData = MediaQueryData(size: uiTabletSize);

  ///模拟桌面 屏幕大小
  const uiDesktopSize = Size(1080, 2160);
  const uiDesktopDeviceData = MediaQueryData(size: uiDesktopSize);

  group("[AppResponsive Test]", () {
    test("test uiWatchSize", () {
      AppResponsive.configure(
        uiWatchDeviceData,
        const ResponsiveLayoutConfig(),
        true,
      );
      expect(AppResponsive().deviceScreenType, DeviceScreenType.watch);
      expect(
        1.w,
        uiWatchSize.width /
            const ResponsiveLayoutConfig().watchDefaultSize.width,
      );
      expect(
        1.h,
        uiWatchSize.height /
            const ResponsiveLayoutConfig().watchDefaultSize.height,
      );
      expect(
        1.w > 1,
        true,
      );
      expect(
        1.h < 1,
        true,
      );
    });

    test("test uiMobileSize", () {
      AppResponsive.configure(
        uiMobileDeviceData,
        const ResponsiveLayoutConfig(),
        true,
      );
      expect(AppResponsive().deviceScreenType, DeviceScreenType.mobile);
      expect(
        1.w,
        uiMobileSize.width /
            const ResponsiveLayoutConfig().mobileDefaultSize.width,
      );
      expect(
        1.h,
        uiMobileSize.height /
            const ResponsiveLayoutConfig().mobileDefaultSize.height,
      );
      expect(
        1.w > 1,
        true,
      );
      expect(
        1.h > 1,
        true,
      );
    });

    test("test uiTabletSize", () {
      AppResponsive.configure(
        uiTabletDeviceData,
        const ResponsiveLayoutConfig(),
        true,
      );
      expect(AppResponsive().deviceScreenType, DeviceScreenType.tablet);
      expect(
        1.w,
        uiTabletSize.width /
            const ResponsiveLayoutConfig().tabletDefaultSize.width,
      );
      expect(
        1.h,
        uiTabletSize.height /
            const ResponsiveLayoutConfig().tabletDefaultSize.height,
      );
      expect(
        1.w > 1,
        true,
      );
      expect(
        1.h == 1,
        true,
      );
    });

    test("test uiDesktopSize", () {
      AppResponsive.configure(
        uiDesktopDeviceData,
        const ResponsiveLayoutConfig(),
        true,
      );
      expect(AppResponsive().deviceScreenType, DeviceScreenType.desktop);
      expect(
        1.w,
        uiDesktopSize.width /
            const ResponsiveLayoutConfig().desktopDefaultSize.width,
      );
      expect(
        1.w == 1,
        true,
      );
      expect(
        1.h > 1,
        true,
      );
    });
  });
}
