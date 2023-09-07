import 'dart:ui';

class ResponsiveLayoutConfig {
  const ResponsiveLayoutConfig({
    this.defaultSize = const Size(360, 690),
    this.mobileDefaultSize = const Size(360, 690),
    this.tabletDefaultSize = const Size(360, 690),
    this.desktopDefaultSize = const Size(360, 690),
    this.watchDefaultSize = const Size(360, 690),
    this.watch = 30,
    this.mobile = 30,
    this.tablet = 30,
    this.desktop = 30,
    this.minAdapt = false,
    this.fixedPreferredOrientations = false,
  });

  final Size defaultSize;
  final Size mobileDefaultSize;
  final Size tabletDefaultSize;
  final Size desktopDefaultSize;
  final Size watchDefaultSize;
  final double watch;
  final double mobile;
  final double tablet;
  final double desktop;
  final bool minAdapt;
  final bool fixedPreferredOrientations;
}