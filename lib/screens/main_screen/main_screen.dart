import 'package:flutter/material.dart';
import 'package:muzik_player/themes/colors.dart';
import 'package:muzik_player/widgets/song_tile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBlack,
      child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return SongTile();
          }),
    );
  }
}
