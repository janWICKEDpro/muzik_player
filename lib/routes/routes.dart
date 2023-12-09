import 'package:go_router/go_router.dart';
import 'package:muzik_player/screens/main_screen/main_screen.dart';

class AppRouter {
  static GoRouter get router => GoRouter(routes: [
        GoRoute(
            path: '/',
            builder: (context, state) {
              return MainScreen();
            })
      ]);
}
