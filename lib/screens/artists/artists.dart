import 'package:flutter/material.dart';
import 'package:muzik_player/constants/enums.dart';
import 'package:muzik_player/providers/songs_provider.dart';
import 'package:muzik_player/screens/artists/widgets/artist_tile.dart';
import 'package:muzik_player/themes/colors.dart';
import 'package:muzik_player/themes/text_theme.dart';
import 'package:provider/provider.dart';

class Artists extends StatefulWidget {
  const Artists({super.key});

  @override
  State<Artists> createState() => _ArtistsState();
}

class _ArtistsState extends State<Artists> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SongsModel>(builder: (context, provider, child) {
      if (provider.state == GetSongState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (provider.state == GetSongState.failed) {
        return Center(
          child: Text(
            'Failed to fetch artists',
            style:
                MuzikPlayerTextTheme.songNameStyle.copyWith(color: Colors.red),
          ),
        );
      } else if (provider.state == GetSongState.empty) {
        return Center(
          child: Text(
            'No songs found',
            style:
                MuzikPlayerTextTheme.songNameStyle.copyWith(color: Colors.red),
          ),
        );
      } else {
        return Container(
            color: AppColors.primaryBlack,
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 5,
              children: [...provider.artists.map((e) => ArtistTile(artist: e))],
            ));
      }
    });
  }
}
