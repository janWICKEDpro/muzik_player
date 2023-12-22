import 'package:flutter/material.dart';
import 'package:muzik_player/themes/colors.dart';
import 'package:muzik_player/themes/text_theme.dart';

class SongTile extends StatelessWidget {
  const SongTile({super.key, this.songName, this.artist, this.onTap});
  final String? songName;
  final String? artist;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: AppColors.primaryGrey,
            image: const DecorationImage(
                image: AssetImage('assets/images/album.png'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10)),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.more_horiz),
      ),
      title: Text('Never the same'),
      subtitle: Text('James Smith'),
      subtitleTextStyle: MuzikPlayerTextTheme.authorNameStyle,
      titleTextStyle: MuzikPlayerTextTheme.songNameStyle,
    );
  }
}
