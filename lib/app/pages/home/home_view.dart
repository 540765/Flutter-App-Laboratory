import 'package:flutter/material.dart';
import 'package:laboratory/app/pages/home/home_landscape/mobile/home_mobile_landscape_view.dart';
import 'package:laboratory/app/pages/home/home_portrait/mobile/home_mobile_portrait_view.dart';
import 'package:laboratory/app_responsive/app_responsive_builder.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppResponsiveBuilder(
      landscapeMobileBuilder: (context) {
        return const HomeMobileLandscapeView();
      },
      landscapeWatchBuilder: (context) {
        return const HomeMobileLandscapeView();
      },
      landscapeTabletBuilder: (context) {
        return const HomeMobileLandscapeView();
      },
      landscapeDesktopBuilder: (context) {
        return const HomeMobileLandscapeView();
      },
      portraitMobileBuilder: (context) {
        return const HomeMobilePortraitView();
      },
      portraitWatchBuilder: (context) {
        return const HomeMobilePortraitView();
      },
      portraitTabletBuilder: (context) {
        return const HomeMobilePortraitView();
      },
      portraitDesktopBuilder: (context) {
        return const HomeMobilePortraitView();
      },
    );
  }
}
