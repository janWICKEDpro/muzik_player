import 'package:flutter/material.dart';
import 'package:muzik_player/themes/text_theme.dart';

class SongTile extends StatelessWidget {
  const SongTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.more_horiz),
      ),
      title: Text('Never the same'),
      subtitle: Text('James Smith'),
      titleTextStyle: MuzikPlayerTextTheme.songNameStyle,
    );
  }
}
