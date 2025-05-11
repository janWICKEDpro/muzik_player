import 'package:flutter/material.dart';
import 'package:muzik_player/constants/enums.dart';
import 'package:muzik_player/providers/songs_provider.dart';
import 'package:muzik_player/screens/albums/widgets/album_tile.dart';
import 'package:muzik_player/themes/colors.dart';
import 'package:muzik_player/themes/text_theme.dart';
import 'package:provider/provider.dart';

class Albums extends StatefulWidget {
  const Albums({super.key});

  @override
  State<Albums> createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
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
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 5,
              children: [
                ...provider.albums.map((e) => AlbumTile(album: e)),
                ...provider.albums.map((e) => AlbumTile(album: e)),
                ...provider.albums.map((e) => AlbumTile(album: e)),
                ...provider.albums.map((e) => AlbumTile(album: e)),
                ...provider.albums.map((e) => AlbumTile(album: e)),
                ...provider.albums.map((e) => AlbumTile(album: e)),
                ...provider.albums.map((e) => AlbumTile(album: e)),
                ...provider.albums.map((e) => AlbumTile(album: e)),
                ...provider.albums.map((e) => AlbumTile(album: e))
              ],
            ));
      }
    });
  }
}
