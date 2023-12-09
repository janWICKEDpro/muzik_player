import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:muzik_player/screens/main_screen/main_screen.dart';

class AppRouter {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();

  final _shellNavigatorKey = GlobalKey<NavigatorState>();
  GoRouter get router => GoRouter(navigatorKey: _rootNavigatorKey, routes: [
        ShellRoute(navigatorKey: _shellNavigatorKey, routes: [
          GoRoute(
              path: '/',
              builder: (context, state) {
                return MainScreen();
              }),
        ])
      ]);
}
