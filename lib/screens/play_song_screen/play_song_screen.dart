import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:blur/blur.dart';
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
      body: Consumer<SongsModel>(builder: (context, provider, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            (provider.currentAudio != null &&
                    provider.currentAudio!.pictures.isNotEmpty)
                ? Blur(
                    blur: 50,
                    blurColor: AppColors.primaryBlack,
                    child: Image.memory(
                      provider.currentAudio!.pictures.first.bytes,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  )
                : Blur(
                    child: Image.asset(
                      'assets/images/album.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
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
                          image: provider.currentAudio!.pictures.isEmpty
                              ? const AssetImage('assets/images/album.png')
                                  as ImageProvider<Object>
                              : MemoryImage(provider.currentAudio!.pictures
                                  .first.bytes) as ImageProvider<Object>),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return SizedBox(
                      width: constraints.maxWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  provider.currentAudio?.title ?? "",
                                  style: MuzikPlayerTextTheme.songNameStyle,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite_outline))
                            ],
                          ),
                          SizedBox(
                            width: constraints.maxWidth,
                            child: Tooltip(
                              showDuration: const Duration(seconds: 3),
                              message: provider.currentAudio?.artist ?? "",
                              child: Text(
                                provider.currentAudio?.artist ?? "",
                                style: MuzikPlayerTextTheme.authorNameStyle,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Slider(
                              padding: EdgeInsets.zero,
                              value: provider.currentDuration?.inSeconds
                                      .toDouble() ??
                                  0,
                              max: provider.currentAudio!.duration?.inSeconds
                                      .toDouble() ??
                                  0,
                              min: 0,
                              onChanged: (val) {
                                provider.currentDuration =
                                    Duration(seconds: val.toInt());
                                provider.seekSong(val);
                              },
                              activeColor: AppColors.primaryWhitishGrey,
                            ),
                          ),
                          const Gap(10),
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
                                  provider.previousSong();
                                },
                                icon: HugeIcon(
                                  icon: HugeIcons.strokeRoundedBackward02,
                                  color: AppColors.primaryWhitishGrey,
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  provider.pauseOrPlay();
                                },
                                icon:
                                    provider.playerState == PlayerState.playing
                                        ? HugeIcon(
                                            icon: HugeIcons.strokeRoundedPause,
                                            color: AppColors.primaryWhitishGrey,
                                          )
                                        : HugeIcon(
                                            icon: HugeIcons.strokeRoundedPlay,
                                            color: AppColors.primaryWhitishGrey,
                                          ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  provider.nextSong();
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
                    );
                  }),
                )
              ],
            )
          ],
        );
      }),
    );
  }
}
