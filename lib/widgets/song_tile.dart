import 'package:flutter/material.dart';
import 'package:muzik_player/themes/text_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongTile extends StatelessWidget {
  const SongTile(
      {super.key,
      this.songName,
      this.artist,
      this.onTap,
      required this.audio,
      required this.onMore,
      required this.controller});
  final String? songName;
  final String? artist;
  final Function()? onTap;
  final Function() onMore;
  final SongModel audio;
  final OnAudioQuery controller;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: QueryArtworkWidget(
        controller: controller,
        id: audio.id,
        type: ArtworkType.AUDIO,
      ),
      trailing: IconButton(
        onPressed: () {
          onMore();
        },
        icon: const Icon(Icons.more_horiz),
      ),
      title: Text(audio.title),
      subtitle: Text('${audio.artist}'),
      subtitleTextStyle: MuzikPlayerTextTheme.authorNameStyle,
      titleTextStyle: MuzikPlayerTextTheme.songNameStyle,
    );
  }
}
