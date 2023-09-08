import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:laboratory/app/pages/home/home_view.dart';

class PublicRoute {
  static List<RouteBase> route = [
    ShellRoute(
      builder: (
        context,
        state,
        child,
      ) {
        return HomeView(
          child: child,
        );
      },
      routes: [
        // each tab has its own child route
        GoRoute(
          path: '/',
          builder: (context, state) => const Text('1'),
        ),
        GoRoute(
          path: '/green',
          builder: (context, state) => const Text('2'),
        ),
        GoRoute(
          path: '/blue',
          builder: (context, state) => const Text('3'),
        ),
      ],
    ),
  ];
}
