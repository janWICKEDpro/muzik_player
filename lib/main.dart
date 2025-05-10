import 'dart:io';

import 'package:flutter/material.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:muzik_player/providers/songs_provider.dart';
import 'package:muzik_player/routes/routes.dart';
import 'package:muzik_player/themes/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await MediaStore.ensureInitialized();
  }
  //   List<Permission> permissions = [
  //   Permission.storage,
  //   Permission.manageExternalStorage
  // ];

  // if ((await mediaStorePlugin.getPlatformSDKInt()) >= 33) {
  //   // permissions.add(Permission.photos);
  //   permissions.add(Permission.audio);
  //   // permissions.add(Permission.videos);
  // }

  // for (var permission in permissions) {
  //   if (await permission.isGranted) {
  //     continue;
  //   } else {
  //     await permission.request();
  //   }
  // }

  // MediaStore.appFolder = "MediaStorePlugin";

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
        routerConfig: router,
        theme: MuzikPlayerTheme.themeData,
      ),
    );
  }
}
