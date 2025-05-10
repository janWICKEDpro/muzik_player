import 'package:flutter/material.dart';
import 'package:muzik_player/constants/enums.dart';
import 'package:muzik_player/providers/songs_provider.dart';
import 'package:muzik_player/themes/colors.dart';
import 'package:muzik_player/themes/text_theme.dart';
import 'package:muzik_player/widgets/song_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final OnAudioQuery _onAudioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongsModel>(builder: (context, provider, child) {
      if (provider.state == GetSongState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (provider.state == GetSongState.failed) {
        return Center(
          child: Text(
            'Failed to fetch songs',
            style:
                MuzikPlayerTextTheme.songNameStyle.copyWith(color: Colors.red),
          ),
        );
      } else {
        return Container(
          color: AppColors.primaryBlack,
          child: ListView.builder(
              itemCount: provider.audios.length,
              itemBuilder: (context, index) {
                final audio = provider.audios[index];
                return SongTile(
                  onTap: ()  {
                    provider.playerSong(audio);
                  },
                  audio: audio,
                  onMore: () {},
                  controller: _onAudioQuery,
                );
              }),
        );
      }
    });
  }
}
