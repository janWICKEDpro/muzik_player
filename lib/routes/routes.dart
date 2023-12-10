import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:muzik_player/screens/albums/albums.dart';
import 'package:muzik_player/screens/artists/artists.dart';
import 'package:muzik_player/screens/main_screen/main_screen.dart';
import 'package:muzik_player/screens/playlists/playlists.dart';
import 'package:muzik_player/widgets/appbar.dart';

class AppRouter {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();

  final _shellNavigatorKey = GlobalKey<NavigatorState>();
  GoRouter get router => GoRouter(
          //  navigatorKey: _rootNavigatorKey,
          routes: [
            ShellRoute(
                //  navigatorKey: _shellNavigatorKey,
                builder: (context, state, child) {
                  return AppTabBar(child: child);
                },
                routes: [
                  GoRoute(
                      path: '/',
                      // parentNavigatorKey: _shellNavigatorKey,
                      builder: (context, state) {
                        return const MainScreen();
                      }),
                  GoRoute(
                      path: '/artists',
                      //   parentNavigatorKey: _shellNavigatorKey,
                      builder: (context, state) {
                        return const Artists();
                      }),
                  GoRoute(
                      path: '/albums',
                      //  parentNavigatorKey: _shellNavigatorKey,
                      builder: (context, state) {
                        return const Albums();
                      }),
                  GoRoute(
                      path: '/playlists',
                      //  parentNavigatorKey: _shellNavigatorKey,
                      builder: (context, state) {
                        return const PlayLists();
                      }),
                ])
          ]);
}
