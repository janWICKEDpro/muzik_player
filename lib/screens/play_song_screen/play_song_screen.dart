import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:muzik_player/providers/songs_provider.dart';
import 'package:muzik_player/themes/colors.dart';
import 'package:muzik_player/themes/text_theme.dart';
import 'package:provider/provider.dart';

class PlaySongScreen extends StatefulWidget {
  const PlaySongScreen({super.key});

  @override
  State<PlaySongScreen> createState() => _PlaySongScreenState();
}

class _PlaySongScreenState extends State<PlaySongScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 80,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: AppColors.primaryGrey,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.playlist_play),
                Text(
                  'Playlist',
                  style: MuzikPlayerTextTheme.songNameStyle,
                ),
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: Transform.rotate(
                    angle: -pi / 2, child: const Icon(Icons.arrow_forward_ios)))
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          (Provider.of<SongsModel>(context).currentAudio != null &&
                  Provider.of<SongsModel>(context)
                      .currentAudio!
                      .pictures
                      .isNotEmpty)
              ? Image.memory(
                  Provider.of<SongsModel>(context)
                      .currentAudio!
                      .pictures
                      .first
                      .bytes,
                  height: double.infinity,
                  width: double.infinity,
                )
              : Image.asset(
                  'assets/images/album.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
          // BackdropFilter(
          //   // filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          //   child: Container(
          //     color: Colors.black.withValues(alpha: 0.3),
          //     width: double.infinity,
          //     height: double.infinity,
          //   ),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/');
                        }
                      },
                      icon: Transform.rotate(
                          angle: pi / 2,
                          child: const Icon(Icons.arrow_forward_ios))),
                  const Text(
                    'Now Playing',
                    style: MuzikPlayerTextTheme.songNameStyle,
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_horiz)),
                ],
              ),
              const Gap(30),
              Hero(
                tag: '12',
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Provider.of<SongsModel>(context)
                                .currentAudio!
                                .pictures
                                .isEmpty
                            ? const AssetImage('assets/images/album.png')
                                as ImageProvider<Object>
                            : MemoryImage(Provider.of<SongsModel>(context)
                                .currentAudio!
                                .pictures
                                .first
                                .bytes) as ImageProvider<Object>),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Provider.of<SongsModel>(context)
                                  .currentAudio
                                  ?.title ??
                              "",
                          style: MuzikPlayerTextTheme.songNameStyle,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_outline))
                      ],
                    ),
                    Text(
                      Provider.of<SongsModel>(context).currentAudio?.artist ??
                          "",
                      style: MuzikPlayerTextTheme.authorNameStyle,
                    ),
                    SizedBox(
                      child: Slider(
                        padding: EdgeInsets.zero,
                        value: Provider.of<SongsModel>(context)
                                .currentDuration
                                ?.inSeconds
                                .toDouble() ??
                            0,
                        max: Provider.of<SongsModel>(context)
                                .currentAudio!
                                .duration
                                ?.inSeconds
                                .toDouble() ??
                            0,
                        min: 0,
                        onChanged: (val) {
                          Provider.of<SongsModel>(context).currentDuration =
                              Duration(seconds: val.toInt());
                          Provider.of<SongsModel>(context).seekSong(val);
                        },
                        activeColor: AppColors.primaryWhitishGrey,
                      ),
                    ),
                    const Gap(40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: HugeIcon(
                            icon: HugeIcons.strokeRoundedShuffle,
                            color: AppColors.primaryWhitishGrey,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                             Provider.of<SongsModel>(context, listen: false)
                                .previousSong();
                          },
                          icon: HugeIcon(
                            icon: HugeIcons.strokeRoundedBackward02,
                            color: AppColors.primaryWhitishGrey,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Provider.of<SongsModel>(context, listen: false)
                                .pauseOrPlay();
                          },
                          icon: HugeIcon(
                            icon: HugeIcons.strokeRoundedPause,
                            color: AppColors.primaryWhitishGrey,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Provider.of<SongsModel>(context, listen: false)
                                .nextSong();
                          },
                          icon: HugeIcon(
                            icon: HugeIcons.strokeRoundedForward02,
                            color: AppColors.primaryWhitishGrey,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: HugeIcon(
                            icon: HugeIcons.strokeRoundedShuffle,
                            color: AppColors.primaryWhitishGrey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
