import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:flutter/material.dart';
import 'package:muzik_player/themes/text_theme.dart';

class SongTile extends StatelessWidget {
  const SongTile(
      {super.key,
      this.songName,
      this.artist,
      this.onTap,
      required this.audio,
      required this.onMore,});
  final String? songName;
  final String? artist;
  final Function()? onTap;
  final Function() onMore;
  final AudioMetadata audio;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: audio.pictures.isEmpty
          ? Image.asset(
              "assets/images/album.png",
              height: 30,
              width: 30,
            )
          : Image.memory(
              audio.pictures.first.bytes,
              height: 30,
              width: 30,
            ),
      trailing: IconButton(
        onPressed: () {
          onMore();
        },
        icon: const Icon(Icons.more_horiz),
      ),
      title: Text(audio.title ?? ""),
      subtitle: Text('${audio.artist}'),
      subtitleTextStyle: MuzikPlayerTextTheme.authorNameStyle,
      titleTextStyle: MuzikPlayerTextTheme.songNameStyle,
    );
  }
}
