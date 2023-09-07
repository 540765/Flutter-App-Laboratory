import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
class RouterLaboratory {
  static GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) {
          return Container();
        },
      ),
      GoRoute(
        name: 'page2',
        path: '/page2',
        builder: (context, state) {
          return Container();
        },
      ),
    ],
  );
}