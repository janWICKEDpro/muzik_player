import 'package:flutter/material.dart';
import 'package:muzik_player/providers/songs_provider.dart';
import 'package:muzik_player/routes/routes.dart';
import 'package:muzik_player/themes/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final router = AppRouter().router();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SongsModel()..getSongs())
      ],
      child: MaterialApp.router(
        // routeInformationParser: AppRouter().router.routeInformationParser,
        // routeInformationProvider: AppRouter().router.routeInformationProvider,
        // routerDelegate: AppRouter().router.routerDelegate,
        routerConfig: router,
        theme: MuzikPlayerTheme.themeData,
      ),
    );
  }
}
