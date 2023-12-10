import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:muzik_player/screens/albums/albums.dart';
import 'package:muzik_player/screens/artists/artists.dart';
import 'package:muzik_player/screens/main_screen/main_screen.dart';
import 'package:muzik_player/screens/play_song_screen/play_song_screen.dart';
import 'package:muzik_player/screens/playlists/playlists.dart';
import 'package:muzik_player/widgets/appbar.dart';

class AppRouter {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();

  final _shellNavigatorKey = GlobalKey<NavigatorState>();
  GoRouter get router => GoRouter(navigatorKey: _rootNavigatorKey, routes: [
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              return AppTabBar(child: child);
            },
            routes: [
              GoRoute(
                  path: '/',
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    return const MainScreen();
                  },
                  routes: [
                    GoRoute(
                        path: 'playing',
                        parentNavigatorKey: _rootNavigatorKey,
                        pageBuilder: (context, state) {
                          return CustomTransitionPage(
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(0.0, 1.0);
                                const end = Offset.zero;
                                const curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                              child: const PlaySongScreen());
                        }),
                  ]),
              GoRoute(
                  path: '/artists',
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    return const Artists();
                  }),
              GoRoute(
                  path: '/albums',
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    return const Albums();
                  }),
              GoRoute(
                  path: '/playlists',
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    return const PlayLists();
                  }),
            ]),
      ]);
}
