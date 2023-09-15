import 'dart:ui';

class ResponsiveLayoutConfig {
  const ResponsiveLayoutConfig({
    this.defaultSize = const Size(360, 640),
        this.watchDefaultSize = const Size(120, 200),
    this.mobileDefaultSize = const Size(360, 640),
    this.tabletDefaultSize = const Size(768, 1024),
    this.desktopDefaultSize = const Size(1080, 900),
    this.watch = 120,
    this.mobile = 360,
    this.tablet = 768,
    this.desktop = 1080,
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