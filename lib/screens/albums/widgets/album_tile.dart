import 'package:flutter/material.dart';
import 'package:muzik_player/services/audio_query_service.dart';
import 'package:muzik_player/themes/colors.dart';
import 'package:muzik_player/themes/text_theme.dart';

class AlbumTile extends StatelessWidget {
  const AlbumTile({super.key, required this.album});
  final Album album;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 100,
            padding: const EdgeInsets.all(4),
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.primaryWhitishGrey,
                borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: album.songs.first.pictures.isEmpty
                  ? Image.asset(
                      "assets/images/album.png",
                      fit: BoxFit.cover,
                    )
                  : Image.memory(
                      album.songs.first.pictures.first.bytes,
                      fit: BoxFit.cover,
                    ),
            )

            // (
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       image: DecorationImage(
            //         fit: BoxFit.contain,
            //         image: album.songs.first.pictures.isEmpty
            //             ? const AssetImage("assets/images/album.png")
            //                 as ImageProvider<Object>
            //             : MemoryImage(album.songs.first.pictures.first.bytes)
            //                 as ImageProvider<Object>,
            //       )),
            // ),
            ),
        Text(
          album.name ?? "Unkown",
          style: MuzikPlayerTextTheme.songNameStyle,
        ),
        Text(
          album.author ?? "Unkown",
          style: MuzikPlayerTextTheme.authorNameStyle,
        )
      ],
    );
  }
}
