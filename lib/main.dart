import 'package:flutter/material.dart';
import 'package:muzik_player/routes/routes.dart';
import 'package:muzik_player/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter().router,
      theme: MuzikPlayerTheme.themeData,
    );
  }
}
